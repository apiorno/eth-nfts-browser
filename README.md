# eth-nfts-browser

Simple eth nfts browser using flutter following CLEAN Architecture with BLoC state management

## Cache / Local storage

Shared Settings choosen by simplicity, may be changed to Sembast in future.

## Testing

Developed with TDD technique. Used simple tests with mockito for whole project but blocs, used bloc_test instead.

## Extra libs

Used

- `Dartz` to enable funcional programming techniques like Either error handling.
- `build_runner` for mocks building
- `internet_connection_checker` to avoid useless api calls when no connection is available

## Pending

● Better UI <br>
● Adjust message in error handling <br>
● UI Test/ Integration Tests <br>

### Bonus
● The input address format should be validated (length and characters is enough). [DONE] <br>
● An Ethereum address can be an EOA (i.e. a regular user wallet) or a smart contract. We
should only allow EOAs (not smart contract addresses) to search for their NFTs. [PENDING] <br>
● Allow the user to search NFTs with certain text.[PENDING] <br>
● Allow the user to filter the POAPs by some useful attribute(s).[PENDING]
