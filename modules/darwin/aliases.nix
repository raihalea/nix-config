{ ... }:

{
  programs.zsh.shellAliases = {
    colima-start = "colima start --cpu 4 --memory 4 --arch aarch64 --vm-type=vz --vz-rosetta --mount-type=virtiofs";
    colima-stop = "colima stop";
    colima-status = "colima status";
  };
}
