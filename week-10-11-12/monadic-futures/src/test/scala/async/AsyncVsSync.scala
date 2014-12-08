package async

import java.util.concurrent.Executors
import org.scalatest.FlatSpec
import scala.language.postfixOps
import scala.concurrent.{ Await, Future, ExecutionContext }
import scala.concurrent.duration._
import java.util.concurrent.TimeUnit

/**
 * Created by Lorand Szakacs
 */
class AsyncVsSyncTest extends FlatSpec {

  lazy val numberOfTopLevelComputations = 100

  lazy val numberOfThreads = 10

  def executionContext(n: Int) = new ExecutionContext {
    val threadPool = Executors.newFixedThreadPool(n)

    def execute(runnable: Runnable) {
      threadPool.submit(runnable)
    }

    def reportFailure(t: Throwable) {}
  }

  lazy val timeout = 1 minute

  def measureTime[T](message: String)(thunk: => T): T = {
    val initialTime: Long = System.nanoTime()
    val result = thunk
    val finishTime: Long = System.nanoTime()
    val time = TimeUnit.MILLISECONDS.convert(finishTime - initialTime, TimeUnit.NANOSECONDS)
    println(s"\n\t--$message: ${time} ms\n")
    result
  }

  behavior of "concurrency"

  it should "run without a problem async" in {
    implicit val ec = executionContext(numberOfThreads)

    measureTime("async") {
      val seqOfFutures: Seq[Future[String]] =
        1 to numberOfTopLevelComputations map { v =>
          Future {
            Thread.sleep(10) //model some computation
            val idF = Future {
              Thread.sleep(20) //model some more computation
              v + 1
            }

            idF map { id =>
              id.toString
            }
          } flatMap identity
        }

      val futureOfList = Future.sequence(seqOfFutures)
      Await.result(futureOfList, timeout)
    }
  }

  it should "run with sync computation iff the numberOfThreads is greater than the the numberOfTopLevelComputations" in {
    implicit val ec = executionContext(numberOfTopLevelComputations + 1)

    measureTime("sync with more threads than top level tasks") {
      val seqOfFutures: Seq[Future[String]] =
        1 to numberOfTopLevelComputations map { v =>
          Future {
            Thread.sleep(10) //model computation
            val idF = Future {
              Thread.sleep(20) //model some more computation
              v + 1
            }
            val id = Await.result(idF, timeout)
            id.toString
          }
        }

      val futureOfList = Future.sequence(seqOfFutures)
      Await.result(futureOfList, timeout)
    }
  }

  it should "timeout with sync computation if the numberOfThreads is smaller than the numberOfTopLevelComputations" in {
    implicit val ec = executionContext(numberOfThreads)

    measureTime("sync") {
      val seqOfFutures: Seq[Future[String]] =
        1 to numberOfTopLevelComputations map { v =>
          Future {
            Thread.sleep(10) //model computation
            val idF = Future {
              Thread.sleep(20) //model some more computation
              v + 1
            }
            val id = Await.result(idF, timeout)
            id.toString
          }
        }

      val futureOfList = Future.sequence(seqOfFutures)
      Await.result(futureOfList, timeout)
    }
  }
}