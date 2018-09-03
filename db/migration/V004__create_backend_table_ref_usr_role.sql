DO $$
DECLARE
  lScriptName    VARCHAR := 'создания таблицы backend.ref_usr_role';
  lScriptVersion VARCHAR := '4';
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
    IF NOT EXISTS(SELECT 1 FROM information_schema.columns a WHERE table_name = 'ref_usr_role'
                                                               AND table_schema = 'backend')
    THEN
      RAISE NOTICE 'Создание таблицы ref_usr_role';

      CREATE TABLE backend.ref_usr_role
      (
        user_id BIGINT NOT NULL,
        role_id BIGINT NOT NULL,
        PRIMARY KEY (user_id, role_id),
        CONSTRAINT fk_usr_ref_usr_role FOREIGN KEY (user_id) REFERENCES backend.usr (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
        CONSTRAINT fk_role_ref_usr_role FOREIGN KEY (role_id) REFERENCES backend.role (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
      );

      ALTER TABLE backend.ref_usr_role
        OWNER TO bug_hunter;
      COMMENT ON TABLE backend.ref_usr_role
      IS 'Таблица для связт ролей и пользователей системы';

      GRANT ALL ON TABLE backend.ref_usr_role TO bug_hunter;
      GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES ON TABLE backend.ref_usr_role TO bug_hunter_roles;
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