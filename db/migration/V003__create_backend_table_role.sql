DO $$
DECLARE
  lScriptName    VARCHAR := 'создания таблицы backend.role';
  lScriptVersion VARCHAR := '3';
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
    IF NOT EXISTS(SELECT 1 FROM information_schema.columns a WHERE table_name = 'role'
                                                               AND table_schema = 'backend')
    THEN
      RAISE NOTICE 'Создание таблицы role';

      CREATE SEQUENCE backend.role_id_seq;
      ALTER TABLE backend.role_id_seq
        OWNER TO bug_hunter;
      GRANT ALL ON SEQUENCE backend.role_id_seq TO bug_hunter, bug_hunter_roles;
      REVOKE ALL ON SEQUENCE backend.role_id_seq FROM bug_hunter;

      CREATE TABLE backend.role
      (
        id       BIGINT NOT NULL DEFAULT nextval('backend.role_id_seq' :: REGCLASS),
        role     VARCHAR(255),
        CONSTRAINT role_id_pk PRIMARY KEY (id)
      );

      ALTER TABLE backend.role
        OWNER TO bug_hunter;
      COMMENT ON TABLE backend.role
      IS 'Таблица для хранения ролей пользователей системы';

      GRANT ALL ON TABLE backend.role TO bug_hunter;
      GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE backend.role TO bug_hunter_roles;
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