package biz.oppenheimer

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class OppenheimerLoadTest extends Simulation {

   val numUsers = System.getProperty("numUsers")
   val baseUrl = System.getProperty("baseUrl")
   val endPoint = System.getProperty("endPoint")

   val httpProtocol = http
        .baseUrl(baseUrl)


    val scn = scenario("fabrick simulation")
        .exec(http("request_0")
            .get(endPoint))

    setUp(scn.inject(rampUsersPerSec(10) to (100) during(60 seconds), constantUsersPerSec(numUsers.toDouble) during (2 minutes)).protocols(httpProtocol))
}
