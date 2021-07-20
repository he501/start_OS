curl --proto '=https' --tlsv1.2 -o RustSetup.sh -sSf https://sh.rustup.rs
chmod 777 RustSetup.sh
expect -c "
spawn ./RustSetup.sh
expect \">\"
send -- \"1\n\"
interact
exit 0
"
rustup component add rls
rm RustSetup.sh
