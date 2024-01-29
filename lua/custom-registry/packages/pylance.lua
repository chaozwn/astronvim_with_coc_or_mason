local Pkg = require "mason-core.package"
return Pkg.new {
  name = "pylance",
  desc = [[Fast, feature-rich language support for Python]],
  homepage = "https://github.com/microsoft/pylance",
  languages = { Pkg.Lang.Python },
  categories = { Pkg.Cat.LSP },
  install = function(ctx)
    ctx.receipt:with_primary_source(ctx.receipt.unmanaged)
    ctx.spawn.bash {
      "-c",
      ("curl -o pylance.zip https://ms-python.gallery.vsassets.io/_apis/public/gallery/publisher/ms-python/extension/vscode-pylance/%s/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"):format(
        ctx.requested_version:or_else "latest"
      ),
    }
    ctx.spawn.unzip { "pylance.zip" }
    ctx.spawn.rm { "pylance.zip" }
    ctx.spawn.bash {
      "-c",
      [[awk 'BEGIN{RS=ORS=";"} /if\(!process/ && !found {sub(/return!0x1/, "return!0x0"); found=1} 1' extension/dist/server.bundle.js | awk 'BEGIN{RS=ORS=";"} /throw new/ && !found {sub(/throw new/, ""); found=1} 1' > extension/dist/server_crack.js]],
    }
    ctx:link_bin(
      "pylance",
      ctx:write_node_exec_wrapper(
        "pylance",
        require("mason-core.path").concat { "extension", "dist", "server_crack.js" }
      )
    )
  end,
}

