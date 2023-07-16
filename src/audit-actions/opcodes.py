import typing


class OpCode(typing.NamedTuple):
    name: str
    cadence_equivalent: str
    tags: typing.List[str]


OPCODES = {
    'STOP': OpCode(name='STOP', cadence_equivalent='panic("STOP opcode encountered")', tags=['moves']),
    'ADD': OpCode(name='ADD', cadence_equivalent='+', tags=[]),
    'MUL': OpCode(name='MUL', cadence_equivalent='*', tags=[]),
    'SUB': OpCode(name='SUB', cadence_equivalent='-', tags=[]),
    'DIV': OpCode(name='DIV', cadence_equivalent='/', tags=[]),
    'SDIV': OpCode(name='SDIV', cadence_equivalent='/', tags=[]),
    'MOD': OpCode(name='MOD', cadence_equivalent='%', tags=[]),
    'SMOD': OpCode(name='SMOD', cadence_equivalent='%', tags=[]),
    'ADDMOD': OpCode(name='ADDMOD', cadence_equivalent='addmod', tags=[]),
    'MULMOD': OpCode(name='MULMOD', cadence_equivalent='mulmod', tags=[]),
    'EXP': OpCode(name='EXP', cadence_equivalent='**', tags=[]),
    'SIGNEXTEND': OpCode(name='SIGNEXTEND', cadence_equivalent='signextend', tags=[]),
    'LT': OpCode(name='LT', cadence_equivalent='<', tags=[]),
    'GT': OpCode(name='GT', cadence_equivalent='>', tags=[]),
    'SLT': OpCode(name='SLT', cadence_equivalent='<', tags=[]),
    'SGT': OpCode(name='SGT', cadence_equivalent='>', tags=[]),
    'EQ': OpCode(name='EQ', cadence_equivalent='==', tags=[]),
    'ISZERO': OpCode(name='ISZERO', cadence_equivalent='!', tags=[]),
    'AND': OpCode(name='AND', cadence_equivalent='&', tags=[]),
    'OR': OpCode(name='OR', cadence_equivalent='|', tags=[]),
    'XOR': OpCode(name='XOR', cadence_equivalent='^', tags=[]),
    'NOT': OpCode(name='NOT', cadence_equivalent='~', tags=[]),
    'BYTE': OpCode(name='BYTE', cadence_equivalent='byte', tags=[]),
    'SHA3': OpCode(name='SHA3', cadence_equivalent='sha3', tags=[]),
    'ADDRESS': OpCode(name='ADDRESS', cadence_equivalent='Address', tags=[]),
    'BALANCE': OpCode(name='BALANCE', cadence_equivalent='getAccountBalance', tags=[]),
    'ORIGIN': OpCode(name='ORIGIN', cadence_equivalent='getTxOrigin', tags=[]),
    'CALLER': OpCode(name='CALLER', cadence_equivalent='getCaller', tags=[]),
    'CALLVALUE': OpCode(name='CALLVALUE', cadence_equivalent='getCallValue', tags=[]),
    'CALLDATALOAD': OpCode(name='CALLDATALOAD', cadence_equivalent='getTransactionArgument', tags=[]),
    'CALLDATASIZE': OpCode(name='CALLDATASIZE', cadence_equivalent='getTransactionArgumentSize', tags=[]),
    'CALLDATACOPY': OpCode(name='CALLDATACOPY', cadence_equivalent='copyTransactionArgument', tags=[]),
    'CODESIZE': OpCode(name='CODESIZE', cadence_equivalent='getCodeSize', tags=[]),
    'CODECOPY': OpCode(name='CODECOPY', cadence_equivalent='copyCode', tags=[]),
    'GASPRICE': OpCode(name='GASPRICE', cadence_equivalent='getGasPrice', tags=[]),
    'EXTCODESIZE': OpCode(name='EXTCODESIZE', cadence_equivalent='getAccountContractSize', tags=[]),
    'EXTCODECOPY': OpCode(name='EXTCODECOPY', cadence_equivalent='copyAccountContract', tags=[]),
    'BLOCKHASH': OpCode(name='BLOCKHASH', cadence_equivalent='getBlockHash', tags=[]),
    'COINBASE': OpCode(name='COINBASE', cadence_equivalent='getBlockCoinbase', tags=[]),
    'TIMESTAMP': OpCode(name='TIMESTAMP', cadence_equivalent='getBlockTimestamp', tags=[]),
    'NUMBER': OpCode(name='NUMBER', cadence_equivalent='getBlockHeight', tags=[]),
    'DIFFICULTY': OpCode(name='DIFFICULTY', cadence_equivalent='getBlockDifficulty', tags=[]),
    'GASLIMIT': OpCode(name='GASLIMIT', cadence_equivalent='getBlockGasLimit', tags=[]),
    'POP': OpCode(name='POP', cadence_equivalent='drop', tags=[]),
    'MLOAD': OpCode(name='MLOAD', cadence_equivalent='load', tags=[]),
    'MSTORE': OpCode(name='MSTORE', cadence_equivalent='store', tags=['moves']),
    'MSTORE8': OpCode(name='MSTORE8', cadence_equivalent='store8', tags=['moves']),
    'SLOAD': OpCode(name='SLOAD', cadence_equivalent='read', tags=[]),
    'SSTORE': OpCode(name='SSTORE', cadence_equivalent='write', tags=['moves']),
    'JUMP': OpCode(name='JUMP', cadence_equivalent='jump', tags=[]),
    'JUMPI': OpCode(name='JUMPI', cadence_equivalent='jumpIf', tags=[]),
    'PC': OpCode(name='PC', cadence_equivalent='getCurrentCodeAddress', tags=[]),
    'MSIZE': OpCode(name='MSIZE', cadence_equivalent='getAccountAvailableBalance', tags=[]),
    'GAS': OpCode(name='GAS', cadence_equivalent='getGasRemaining', tags=[]),
    'JUMPDEST': OpCode(name='JUMPDEST', cadence_equivalent='', tags=[]),
    'CREATE': OpCode(name='CREATE', cadence_equivalent='createAccount', tags=['moves']),
    'CALL': OpCode(name='CALL', cadence_equivalent='executeScript', tags=['moves']),
    'CALLCODE': OpCode(name='CALLCODE', cadence_equivalent='executeScript', tags=['moves']),
    'RETURN': OpCode(name='RETURN', cadence_equivalent='return', tags=[]),
    'DELEGATECALL': OpCode(name='DELEGATECALL', cadence_equivalent='executeScript', tags=['moves']),
    'STATICCALL': OpCode(name='STATICCALL', cadence_equivalent='executeScript', tags=[]),
    'REVERT': OpCode(name='REVERT', cadence_equivalent='revert', tags=[]),
    'INVALID': OpCode(name='INVALID', cadence_equivalent='', tags=[]),
    'SELFDESTRUCT': OpCode(name='SELFDESTRUCT', cadence_equivalent='destroy', tags=['moves']),
}


def get_cadence_equivalent(opcode_name: str) -> typing.Optional[str]:
    return OPCODES[opcode_name].cadence_equivalent if opcode_name in OPCODES else None
