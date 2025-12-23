{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  wrapGAppsHook4,
  nix-update-script,

  cargo-tauri,
  nodejs,
  pkg-config,
  pnpm,

  glib-networking,
  libappindicator-gtk3,
  openssl,
  webkitgtk_4_1,
}:

let
  # You must keep a Cargo.lock beside this nix file.
  # Generate it from your chosen checkout in backend/ and copy it here.
  localCargoLock = ./Cargo.lock;
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "atuin-desktop";
  version = "0.2.0"; # override when you pin a different commit/tag

  src = fetchFromGitHub {
    owner = "atuinsh";
    repo = "desktop";
    rev = "v${finalAttrs.version}"; # or your custom commit
    hash = "sha256-dm+JTs/U6sWJ8hQRxfYMaJIenQ+HYPj1rfvrXvkEMRc="; #"sha256-dm+JTs/U6sWJ8hQRxfYMaJIenQ+HYPj1rfvrXvkEMRc=";
  };

  cargoRoot = "backend";
  buildAndTestSubdir = finalAttrs.cargoRoot;

  # Make sure the lock is present in the *source* tree for validation
  postUnpack = ''
    cp ${localCargoLock} "$sourceRoot/${finalAttrs.cargoRoot}/Cargo.lock"
  '';

  cargoLock = {
    lockFile = localCargoLock;

    # If nix asks for git-dep hashes, add them here.
    outputHashes = {
      # First pass: use fakeHash to make nix tell you the real one.
      "atuin-client-18.8.0" = "sha256-wvQ5MmTGjaJRW+bE4ONwyMB8Y7vbfPpZqvcyW9rHFNU=";
      "sqlparser-0.59.0" = "sha256-LpCxYllM08KEVJzYYFTjwOE8fInSpHRFRRzEifCFR9A=";  
    };
  };

  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 2;
    hash = "sha256-2i1mL4HwwiXrmM1qaWvHhm27U2/oElbOpnXh09ziamo="; # first build will print the real one
  };

  nativeBuildInputs = [
    cargo-tauri.hook
    pnpm.configHook
    nodejs
    pkg-config
  ] ++ lib.optionals stdenv.hostPlatform.isLinux [
    wrapGAppsHook4
  ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    glib-networking
    libappindicator-gtk3
    openssl
    webkitgtk_4_1
  ];

  env.NODE_OPTIONS = "--max-old-space-size=12288";

  tauriConf = builtins.toJSON { bundle.createUpdaterArtifacts = false; };
  passAsFile = [ "tauriConf" ];

  preBuild = ''
    npm rebuild ts-tiny-activerecord
    tauriBuildFlags+=(
      "--config"
      "$tauriConfPath"
    )
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Local-first, executable runbook editor";
    homepage = "https://atuin.sh";
    downloadPage = "https://github.com/atuinsh/desktop";
    changelog = "https://github.com/atuinsh/desktop/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ adda dzervas randoneering ];
    mainProgram = "atuin-desktop";
    platforms = with lib.platforms; windows ++ darwin ++ linux;
    broken = stdenv.hostPlatform.isDarwin;
  };
})
