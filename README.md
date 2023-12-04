Run from home directory:
```
sudo curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --init none --no-confirm
sudo chown -R $USER: /nix
git clone https://github.com/NoelJacob/home-manager.git
nix run home-manager/master -- init --switch ./home-manager
hms init
```
