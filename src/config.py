import json
import logging
from pathlib import Path

from flow_py_sdk.cadence import Address
from flow_py_sdk.signer import InMemorySigner, HashAlgo, SignAlgo

log = logging.getLogger(__name__)


class Config(object):
    def __init__(self, config_location: Path, address: Address, private_key: str) -> None:
        
        super().__init__()
        
       
        try:
            with open(config_location) as json_file:
                data = json.load(json_file)
                # Flow Testnet parameters are passed here at the point
                self.access_node_host: str = data["networks"]["testnet"]["host"]
                self.access_node_port: int = data["networks"]["testnet"]["port"]

                self.service_account_key_id: int = 0
                #The account address of the user is passed here
                self.service_account_address = Address.from_hex(
                    address
                )
                #The private key of the user would be required
                self.service_account_signer = InMemorySigner(
                    hash_algo=HashAlgo.from_string(
                        data["accounts"]["testnet-account"]["hashAlgorithm"]
                    ),
                    sign_algo=SignAlgo.from_string(
                        data["accounts"]["testnet-account"]["sigAlgorithm"]
                    ),
                    private_key_hex= private_key,
                )
        except Exception:
            log.warning(
                f"Cannot open {config_location}, using default settings",
                exc_info=True,
                stack_info=True,
            )

