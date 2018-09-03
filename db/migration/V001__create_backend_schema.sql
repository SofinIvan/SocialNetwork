DO $$
DECLARE
  lScriptName    VARCHAR := 'создания схемы backend';
  lScriptVersion VARCHAR := '1';
  lErrorStack    TEXT;
  lErrorState    TEXT;
  lErrorMsg      TEXT;
  lErrorDetail   TEXT;
  lErrorHint     TEXT;
BEGIN
  BEGIN
    RAISE NOTICE 'Начало % ...', lScriptName;

    CREATE SCHEMA IF NOT EXISTS backend
      AUTHORIZATION bug_hunter;

    GRANT ALL ON SCHEMA backend TO bug_hunter_roles;

    COMMENT ON SCHEMA backend
    IS 'Social network backend schema';

    RAISE NOTICE 'Процесс % завершен', lScriptName;

    EXCEPTION
    WHEN OTHERS
      THEN
        GET STACKED DIAGNOSTICS
        lErrorState = RETURNED_SQLSTATE,
        lErrorMsg = MESSAGE_TEXT,
        lErrorDetail = PG_EXCEPTION_DETAIL,
        lErrorHint = PG_EXCEPTION_HINT,
        lErrorStack = PG_EXCEPTION_CONTEXT;
        RAISE EXCEPTION ' в скрипте "%" при выполнении кода.
  код       : %
  сообщение : %
  описание  : %
  подсказка : %
  контекст  : %', lScriptVersion, lErrorState, lErrorMsg, lErrorDetail, lErrorHint, lErrorStack;
  END;
END $$