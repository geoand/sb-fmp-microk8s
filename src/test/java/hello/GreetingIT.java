package hello;

import static io.restassured.RestAssured.given;
import static org.hamcrest.core.Is.is;

import org.arquillian.cube.kubernetes.impl.requirement.RequiresKubernetes;
import org.jboss.arquillian.junit.Arquillian;
import org.junit.Test;
import org.junit.runner.RunWith;

@RequiresKubernetes
@RunWith(Arquillian.class)
public class GreetingIT {

  private static final String HOST = System.getProperty("service.host");
  private static final Integer PORT = Integer.valueOf(System.getProperty("service.port"));

  @Test
  public void testGreetingEndpoint() {
    given()
        .baseUri(String.format("http://%s:%d", HOST, PORT))
        .get("greeting")
        .then()
        .statusCode(200)
        .body("message", is("Hello Spring Boot"));
  }

}
