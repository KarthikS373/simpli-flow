from flow_py_sdk import (
    flow_client,
    ProposalKey,
    Tx,
    TransactionTemplates,
    cadence,
)
import asyncio
from config import Config


# -------------------------------------------------------------------------
# Contract Deployment
# -------------------------------------------------------------------------
# parameters passed from gpt can also pass the contract later
async def deployment(address,private_key,contracts):
   #contract created by gpt is placed here
   #in order to run more than one time change the name of contract on bothh position 
    contract = contracts
    contract_source_hex = bytes(contract["source"], "UTF-8").hex()
    #the parameter is given only till gpt is not connected with config.py
    abc = Config("../flow.json",address,private_key)
    #Comment above and Uncomment below in case of gpt connection
    #abc = Config;
    async with flow_client(
        host=abc.access_node_host, port=abc.access_node_port
            ) as client:
                    latest_block = await client.get_latest_block()
                    proposer = await client.get_account_at_latest_block(
                    address=abc.service_account_address.bytes
                    )
                    contract_name = cadence.String(contract["Name"])
                    contract_code = cadence.String(contract_source_hex)
                    transaction = (
                    Tx(
                    code=TransactionTemplates.addAccountContractTemplate,
                    reference_block_id=latest_block.id,
                    payer=abc.service_account_address,  #all parameters are being taken from config.py
                    proposal_key=ProposalKey(
                        key_address=abc.service_account_address,
                        key_id=abc.service_account_key_id,
                        key_sequence_number=proposer.keys[
                           abc.service_account_key_id
                        ].sequence_number,
                    ),
                    )
                    .add_arguments(contract_name)
                    .add_arguments(contract_code)
                    .add_authorizers(abc.service_account_address)
                    .with_envelope_signature(
                    abc.service_account_address, 0, abc.service_account_signer
                    )  
                    )
    result = await client.execute_transaction(transaction)
    print(result.id.hex())
    answer = result.id.hex()
    return result.id.hex()
    
if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    #can change the address and private key using the testnet
    loop.run_until_complete(deployment("4edbd4bc470a8479","<PRIVATE_KEY>",{
            "Name": "Test14",
            "source": """pub contract Test14 {
                                pub fun add(a: Int, b: Int): Int {
                                    return a + b
                                }
                                }""",
    }))
    

