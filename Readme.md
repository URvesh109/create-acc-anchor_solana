# Create account using Anchor

### If you're running solana for the first time, generate a wallet.

```
solana-keygen new
```

### Build Command

```
anchor build
```

### Command to set config provider for localnet

```
solana config set --url l
```

### Command to set config provider for devnet

```
solana config set --url devnet
```

### Command to set config provider for devnet

```
solana config set --url testnet
```

### Get current config provider

```
solana config get
```

### If you get insufficient balance error, try to airdrop some funds

```
solana airdrop 1 yourPubKey --url devnet
```

### To retreive to program ID after running anchor build use this command

```
solana address -k target/deploy/hello_world-keypair.json
```

### Test it in localnet

```
anchor test --provider.cluster l
```

### Test it in devnet

```
anchor test --provider.cluster devnet
```

### Test it using anchor-rust client

```
cd client/base_acc
./run-test.sh
```
