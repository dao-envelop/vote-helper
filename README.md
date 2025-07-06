## Envelop V1 SBT vote helper

## Usage

### Build

```shell
$ forge build
```

### Test
!!! On forked mainnet chain only!!!

```bash
$ forge test --fork-url polygon  --fork-block-number 73000000 -vv
```
### Deploy

```shell
$ forge script script/Deploy.s.sol:DeployScript --rpc-url polygon --account env_deploy_2025 --sender 0x13B9cBcB46aD79878af8c9faa835Bee19B977D3D --broadcast --verify  --etherscan-api-key $ETHERSCAN_TOKEN
```

  
**EnvelopSBTV1VoteHelper**  
  https://polygonscan.com/address/0xBDb5201565925AE934A5622F0E7091aFFceed5EB#code
