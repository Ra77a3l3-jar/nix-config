$env.PATH = (
    $env.PATH
    | prepend [
        ($nu.home-dir | path join ".nix-profile" "bin")
        ($nu.home-dir | path join ".local" "bin")
        ($nu.home-dir | path join ".cargo" "bin")
    ]
    | uniq
)
