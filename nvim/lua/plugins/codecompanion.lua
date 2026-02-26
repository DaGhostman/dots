return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            opts = {

            },
            strategies = {
                chat = {
                    adapter = "qwen3"
                },
                inline = {
                    adapter = "qwen3",
                }
            },
            opts = {
                stream = false,
            },
            adapters = {
                http = {
                    qwen3 = function()
                        return require("codecompanion.adapters").extend("openai_compatible", {
                            name = "qwen3-coder-next",
                            env = {
                                url = "http://localhost:11434"
                            },
                            schema = {
                                model = {
                                    default = "qwen3-coder-next",
                                },
                                max_tokens = {
                                    default = 32768,
                                }
                            },
                            opts = {
                                stream = false,
                            }
                        })
                    end,
                    codestral = function()
                        return require("codecompanion.adapters").extend("openai_compatible", {
                            name = "codestral",
                            env = {
                                url = "https://codestral.mistral.ai",
                                api_key = "zFnmJV5QXEuhQoG08qtQZ3PWzdHWHKUe",
                                chat_url = "/v1/chat/completions",
                            },
                            handlers = {
                                form_parameters = function(self, params, messages)
                                    params.stream_options = nil
                                    params.options = nil

                                    return params
                                end
                            },
                            schema = {
                                model = {
                                    default = "codestral-latest",
                                },
                                temperature = {
                                    default = 0.2,
                                    mapping = "parameteres",
                                }
                            }
                        })
                    end
                }
            },
        }
    }
}
