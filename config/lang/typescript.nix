{ pkgs, lib, ... }:
{

  plugins = {
    lsp.enabledServers = [
      {
        name = "emmet_language_server";
        extraOptions = {
          cmd = [
            (lib.getExe pkgs.emmet-language-server)
            "--stdio"
          ];

          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
          ];
        };
      }
    ];

    conform-nvim = {
      formattersByFt = {
        typescript = [ "eslint_d" ];
        javascript = [ "eslint_d" ];
      };

      formatters.eslint_d = {
        command = "${pkgs.eslint_d}/bin/eslint_d";
      };
    };

    lsp.servers = {
      tsserver = {
        enable = true;
        filetypes = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
        ];

        settings = {
          complete_function_calls = true;
          vtsls = {
            enableMoveToFileCodeAction = true;
            autoUseWorkspaceTsdk = true;
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true;
              };
            };
          };

          typescript = {
            updateImportsOnFileMove.enabled = "always";
            suggest = {
              completeFunctionCalls = true;
            };

            inlayHints = {
              enumMemberValues.enabled = true;
              functionLikeReturnTypes.enabled = true;
              parameterNames.enabled = "literals";
              parameterTypes.enabled = true;
              propertyDeclarationTypes.enabled = true;
              variableType.enabled = false;
            };
          };
        };
      };
    };

    lint = {
      lintersByFt = {
        typescript = [ "eslint_d" ];
        javascript = [ "eslint_d" ];
      };

      linters.eslint_d = {
        cmd = "${pkgs.eslint_d}/bin/eslint_d";
      };
    };

    ts-autotag.enable = true;
  };
}
