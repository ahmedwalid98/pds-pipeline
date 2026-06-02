def normalize_value(value):
    if value is None:
        return ""

    if isinstance(value, bool):
        return "TRUE" if value else "FALSE"

    if isinstance(value, (bytes, bytearray)):
        return value.decode("cp1252", errors="replace")

    if isinstance(value, str):
        try:
            raw = value.encode("cp850")
            return raw.decode("cp1252", errors="replace")
        except (UnicodeEncodeError, UnicodeDecodeError):
            return value

    return str(value)
