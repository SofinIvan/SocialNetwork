DO $$
DECLARE
  lScriptName    VARCHAR := 'создания таблицы backend.usr';
  lScriptVersion VARCHAR := '2';
  lErrorStack    TEXT;
  lErrorState    TEXT;
  lErrorMsg      TEXT;
  lErrorDetail   TEXT;
  lErrorHint     TEXT;
BEGIN
  BEGIN
    RAISE NOTICE 'Начало % ...', lScriptName;

    -- ****************************************************************************************************************************************
    --     Создание таблицы usr
    -- ****************************************************************************************************************************************
    IF NOT EXISTS(SELECT 1
                  FROM information_schema.columns a
                  WHERE table_name = 'usr'
                    AND table_schema = 'backend')
    THEN
      RAISE NOTICE 'Создание таблицы usr';

      CREATE SEQUENCE backend.usr_id_seq;
      ALTER TABLE backend.usr_id_seq
        OWNER TO bug_hunter;
      GRANT ALL ON SEQUENCE backend.usr_id_seq TO bug_hunter, bug_hunter_roles;
      REVOKE ALL ON SEQUENCE backend.usr_id_seq FROM bug_hunter;

      CREATE TABLE backend.usr
      (
        id       BIGINT NOT NULL DEFAULT nextval('backend.usr_id_seq' :: REGCLASS),
        active   INT             DEFAULT NULL,
        email    VARCHAR(255),
        name     VARCHAR(50),
        surname  VARCHAR(50),
        password VARCHAR(255),
        CONSTRAINT usr_id_pk PRIMARY KEY (id)
      );

      ALTER TABLE backend.usr
        OWNER TO bug_hunter;
      COMMENT ON TABLE backend.usr
      IS 'Таблица для хранения пользователей системы';

      GRANT ALL ON TABLE backend.usr TO bug_hunter;
      GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE backend.usr TO bug_hunter_roles;
    END IF;

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
END $$;