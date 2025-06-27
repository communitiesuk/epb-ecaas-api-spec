import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "./responses/models.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Energy Calculation as a Service" })
@info(#{ version: "0.1.0", license: #{ name: "MIT", url: "https://opensource.org/licenses/MIT" } })
@server("https://api.building-energy-calculator-integration.communities.gov.uk", "Integration environment API instance")
namespace EnergyCalculationAsAService;

@useRef("./schemas/fhs_input.schema.json")
model FhsComplianceInput {}

@route("/")
@get
@summary("Get information about the ECaaS API")
op ApiMetadata(): OkResponse;

/**
 * Check compliance with the Future Homes Standard (FHS) based on the energy performance of a building calculated using the Home Energy Model (HEM).
 */
@route("/beta/future-homes-standard-compliance")
@post
@summary("Check Future Homes Standard (FHS) compliance")
op FHSCompliance(
  @body
  body: FhsComplianceInput,
):
  /** A summary of a successful HEM calculation to determine compliance with the Future Homes Standard (FHS). */
  | FhsOkResponse<FhsComplianceResponse>
  | FhsUnprocessableError
  | FhsCalculationFailedError
  | FhsUnimplementedError;
