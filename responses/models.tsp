import "@typespec/http";
import "./jsonapi.tsp";

using Http;

@doc("A summary of a successful HEM calculation to determine compliance with the Future Homes Standard (FHS).")
model JsonApiFhsComplianceResponse {
  data: FhsComplianceResponse,
  meta: FhsMeta
}

model FhsComplianceResponse {
  /**
   * The calculated DER (Dwelling Emission Rate) of the building. Unit: kgCO₂e/m².yr.
   */
  dwelling_emission_rate?: numeric;

  /**
   * The determined TER (Target Emission Rate) used for the calculation for this building. Unit: kgCO₂e/m².yr.
   */
  target_emission_rate?: numeric;

  /**
   * Whether this calculation determines that the building with the provided properties complies with the Future Homes Standard for emission rate.
   */
  emission_rate_compliant?: boolean;

  /**
   * The calculated DPER (Dwelling Primary Energy Rate) of the building. Unit: kWh/m².yr.
   */
  dwelling_primary_energy_rate?: numeric;

  /**
   * The determined TPER (Target Primary Energy Rate) used for the calculation for this building. Unit: kWh/m².yr.
   */
  target_primary_energy_rate?: numeric;

  /**
   * Whether the calculated Dwelling Primary Energy Rate is compliant with FHS.
   */
  primary_energy_rate_compliant?: boolean;

  /**
   * The calculated DFEE (Dwelling Fabric Energy Efficiency) of the building. Unit: kWh/m².yr.
   */
  dwelling_fabric_energy_efficiency?: numeric;

  /**
   * The determined TPEE (Target Fabric Energy Efficiency) of the building. Unit: kWh/m².yr.
   */
  target_fabric_energy_efficiency?: numeric;

  /**
   * Whether the calculated Dwelling Fabric Energy Efficiency is compliant with FHS.
   */
  fabric_energy_efficiency_compliant?: boolean;

  energy_demand?: FhsEnergyDemand;
  delivered_energy_use?: FhsDeliveredEnergyUse;
  energy_use_by_fuel?: Record<FhsEnergyPerformanceValue>;
}

model FhsEnergyDemand {
  space_heating?: FhsEnergyPerformanceValue;
  space_cooling?: FhsEnergyPerformanceValue;
}

model FhsDeliveredEnergyUse {
  total?: FhsEnergyPerformanceValue;
  by_system?: Record<FhsEnergyPerformanceValue>;
}

model FhsEnergyPerformanceValue {
  /**
   * The actual measured energy performance for a particular metric. Unit: kWh/m².yr.
   */
  actual?: numeric;

  /**
   * The notional energy performance for a particular metric. Unit: kWh/m².yr.
   */
  notional?: numeric;
}

model FhsMeta {
  /**
   * An identifier representing which version of HEM (the specification) was used, or available to be used, in this calculation.
   */
  @example("0.32")
  hem_version: string;

  /**
   * The date when the version of the HEM specification being used was published. Format: YYYY-MM-DD.
   */
  @example(plainDate.fromISO("2025-02-15"))
  hem_version_date: plainDate;

  /**
   * An identifier representing which version of FHS (Future Homes Standard) (the specification) was used, or available to be used, in this calculation.
   */
  @example("0.23")
  fhs_version: string;

  /**
   * The date when the version of the FHS specification being used was published. Format: YYYY-MM-DD.
   */
  @example(plainDate.fromISO("2025-02-15"))
  fhs_version_date: plainDate;

  /**
   * A unique identifier, usually a SHA, for the version of the HEM software library being used for this calculation.
   */
  @example("521c68bd9c715f82205d7d1afd7b88d038839d26")
  software_version?: string;

  /**
   * A unique identifier for the request made against this ECaaS service. This can be referenced when e.g. raising support queries.
   */
  @example("b6e02d18-f919-490e-bd1b-40d85d8ac456")
  ecaas_request_id?: string;
}

model FhsDataResponse<T> {
    data: T,
    meta: FhsMeta
}

model FhsErrorResponse {
    errors: JsonApiOnePointOneErrors;
    meta: FhsMeta;
}

@mediaTypeHint("application/vnd.api+json")
model FhsOkResponse<T> {
    ...OkResponse,
    ...Body<FhsDataResponse<T>>,
}