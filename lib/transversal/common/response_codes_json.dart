enum ResponseCodesJson {
  ok(200),
  created(201),
  accepted(202),
  noContent(204),
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  methodNotAllowed(405),
  conflict(409),
  unsupportedMediaType(415),
  unprocessableEntity(422),
  internalServerError(500),
  notImplemented(501),
  badGateway(502),
  serviceUnavailable(503),
  gatewayTimeout(504),
  invalidData(999);

  final int value;
  const ResponseCodesJson(this.value);

  static ResponseCodesJson? fromValue(int? value) {
    if (value == null) return null;
    return ResponseCodesJson.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ResponseCodesJson.invalidData,
    );
  }
}