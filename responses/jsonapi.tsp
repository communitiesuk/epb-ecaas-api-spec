import "@typespec/json-schema";

using JsonSchema;

@uniqueItems()
model JsonApiOnePointOneErrors is JsonApiOnePointOneError[];

// ideally definition here of JsonApiOnePointOneError would enforce presence of at least field in an error object
// but perhaps an empty one is unlikely to happen in practice
@doc("A JSON API error object. At least of the properties must be set.")
model JsonApiOnePointOneError {
  /**
   * A unique identifier for this particular occurrence of the problem.
   */
  id?: string;

  links?: JsonApiOnePointOneErrorLinks;

  /**
   * The HTTP status code applicable to this problem, expressed as a string value.
   */
  status?: string;

  /**
   * An application-specific error code, expressed as a string value.
   */
  code?: string;

  /**
   * A short, human-readable summary of the problem. It **SHOULD NOT** change from occurrence to occurrence of the problem, except for purposes of localization.
   */
  title?: string;

  /**
   * A human-readable explanation specific to this occurrence of the problem.
   */
  detail?: string;

  source?: JsonApiOnePointOneErrorSource;
  meta?: JsonApiOnePointOneMeta;
}

/**
 * The error links object **MAY** contain the following members: about.
 */
model JsonApiOnePointOneErrorLinks {
  about?: JsonApiOnePointOneLink,
  type?: JsonApiOnePointOneLink,
}

model JsonApiOnePointOneErrorSource {
  /**
   * A JSON Pointer [RFC6901] to the associated entity in the request document [e.g. "/data" for a primary data object, or "/data/attributes/title" for a specific attribute].
   */
  @pattern("^(?:\\\\/(?:[^~/]|~0|~1)*)*$") pointer?: string;

  /**
   * A string indicating which query parameter caused the error.
   */
  parameter?: string;

  /**
   * A string indicating the name of a single request header which caused the error.
   */
  header?: string;
}

model JsonApiOnePointOneLinkObject {
  href: JsonApiOnePointOneLinkUrl;
  meta?: JsonApiOnePointOneMeta;
  rel?: string;
  title?: string;
  type?: string;
  hreflang?: string;
  describedby?: JsonApiOnePointOneLink;
}

/**
 * A string containing the link's URL.
 */
@pattern("^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\\\\?([^#]*))?(#(.*))?", "Must conform to URI pattern as per https://tools.ietf.org/html/rfc3986#appendix-B")
scalar JsonApiOnePointOneLinkUrl extends url;

/**
 * A link **MUST** be represented as either: a string containing the link's URL or a link object.
 */
@OpenAPI.oneOf
union JsonApiOnePointOneLink {
  JsonApiOnePointOneLinkUrl,
  JsonApiOnePointOneLinkObject,
}

model JsonApiOnePointOneLinks {}

/**
 * Nonstandard meta-information that can not be represented as an attribute or relationship.
 */
union JsonApiOnePointOneMeta {
  JsonApiOnePointOneMemberName,
  JsonApiOnePointOneAtMemberName,
}

@doc("@member name may contain any valid JSON value.")
model JsonApiOnePointOneAtMemberName extends Record<JsonApiOnePointOneMemberNameString> {}

@doc("Member name may contain any valid JSON value.")
model JsonApiOnePointOneMemberName extends Record<JsonApiOnePointOneMemberNameString> {}

/**
 * A valid string value for a JSON API member name.
 */
@minLength(1)
@pattern("^[a-zA-Z0-9]{1}(?:[-\\w]*[a-zA-Z0-9])?$")
scalar JsonApiOnePointOneMemberNameString extends string;