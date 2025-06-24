return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", "git" },
	settings = {
		nixd = {
			nixpkgs = {
				-- expr = "import <nixpkgs> { }",
				expr = 'import (builtins.getFlake "/home/liam/nix-dots").inputs.nixpkgs { }',
			},
		},
		formatting = {
			command = { "alejandra" },
		},

		options = {
			nixos = {
				expr = '(builtins.getFlake "/home/liam/nix-dots").nixosConfigurations.vivo.options',
			},
			home_manager = {
				expr = '(builtins.getFlake "/home/liam/nix-dots").homeConfigurations.vivo.options',
			},
		},
	},

	-- settings = {
	--    nixd = {
	--      nixpkgs = {
	--        expr = "import <nixpkgs> { }"
	--        expr = "import (builtins.getFlake \"/home/liam/nix-dots\").inputs.nixpkgs { }"
	--      },
	--      options = {
	--        nixos = {
	--            expr = '(builtins.getFlake \"/home/liam/nix-dots\").nixosConfigurations.vivo.options',
	--        },
	--        home_manager = {
	--            expr = '(builtins.getFlake \"/home/liam/nix-dots\").homeConfigurations.vivo.options',
	--        },
	--      },
	--    }
	--  },
}
