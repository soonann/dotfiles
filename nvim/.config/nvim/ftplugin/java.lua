-- local config = {
--   cmd = { '/usr/bin/jdtls' },
--   root_dir = vim.fs.dirname(
--     vim.fs.find({ 'gradlew', '.git', 'mvnw', 'Main.java' }, { upward = true })[1]
--   ),
-- }
-- require('jdtls').start_or_attach(config)

-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- local config = {
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = {

--     -- 💀
--     'java', -- or '/path/to/java17_or_newer/bin/java'
--     -- depends on if `java` is in your $PATH env variable and if it points to the right version.

--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-Xmx1g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

--     -- 💀
--     '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.800.v20240304-1850.jar',
--     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--     -- Must point to the                                                     Change this to
--     -- eclipse.jdt.ls installation                                           the actual version


--     -- 💀
--     '-configuration', '/usr/share/java/jdtls/config_linux/config.ini',
--     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--     -- Must point to the                      Change to one of `linux`, `win` or `mac`
--     -- eclipse.jdt.ls installation            Depending on your system.


--     -- 💀
--     -- See `data directory configuration` section in the README
--     '-data', '/home/soonann/.cache/jdtls/workspace'
--   },
