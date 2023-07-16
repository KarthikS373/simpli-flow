import math
from typing import List

import opcodes as oc


class Block:
    def __init__(self, address):
        self.address = address
        self.instructions = []

    def add_instruction(self, instruction):
        self.instructions.append(instruction)


class Instruction:
    def __init__(self, instruction, address, arguments):
        self.instruction = instruction
        self.address = address
        self.arguments = arguments

    def __repr__(self):
        return self.instruction.name


class Parser:
    @staticmethod
    def parse(contract_code):
        opcodes = Parser.__parse_ops(contract_code)
        optimized_opcodes = Parser.__optimize(opcodes)
        blocks = Parser.__parse_blocks(optimized_opcodes)
        return blocks

    @staticmethod
    def __parse_ops(contract_code):
        opcodes = []
        address = 0

        while contract_code:
            offset = 0
            instruction = contract_code[0:2]
            contract_code = contract_code[2:]
            offset += 1
            instr = oc.get_opcode_by_code(instruction)
            args = None

            if instr.args > 0:
                if len(contract_code) < 2 * instr.args:
                    opcodes.append(Instruction(
                        oc.get_opcode_by_mnemonic('THROW'), address, None))
                    break
                args = [int(contract_code[0:2 * instr.args], 16)]
                contract_code = contract_code[2 * instr.args:]
                offset += instr.args

            opcodes.append(Instruction(instr, address, args))
            address += offset

        return opcodes

    @staticmethod
    def __parse_blocks(instructions):
        blocks = []
        current_block = Block(instructions[0].address)

        for operation in instructions:
            if operation.instruction.name == 'JUMPDEST':
                blocks.append(current_block)
                current_block = Block(operation.address)

            current_block.add_instruction(operation)

        blocks.append(current_block)
        return blocks

    @staticmethod
    def __optimize(opcodes):
        Parser.__optimize_jump_args(opcodes)
        last_len = len(opcodes) + 1

        for _ in range(2):
            last_len = len(opcodes)
            Parser.__optimize_arguments(opcodes)
            Parser.__optimize_math(opcodes)

        Parser.__optimize_arguments(opcodes)
        return opcodes

    @staticmethod
    def __optimize_jump_args(opcodes):
        i = 0
        while i < len(opcodes) - 2:
            if 'PUSH' in opcodes[i].instruction.name:
                if 'JUMP' == opcodes[i + 1].instruction.name:
                    opcodes[i + 1].arguments = opcodes[i].arguments
                    del opcodes[i]
                elif 'PUSH' in opcodes[i + 1].instruction.name and 'JUMPI' == opcodes[i + 2].instruction.name:
                    opcodes[i + 1].arguments = opcodes[i].arguments + \
                        opcodes[i + 1].arguments
                    del opcodes[i]
                    del opcodes[i + 1]
            i += 1

    @staticmethod
    def __optimize_arguments(opcodes):
        i = 0
        while i < len(opcodes):
            num_pushes = opcodes[i].instruction.removed
            args = []
            not_static = num_pushes == 0

            if opcodes[i].arguments is not None:
                not_static = True
                num_pushes = 0

            if 'DUP' in opcodes[i].instruction.name or 'SWAP' in opcodes[i].instruction.name:
                i += 1
                continue

            if i - num_pushes < 0:
                break

            for push_num in range(i - num_pushes, i):
                not_static = not_static or 'PUSH' not in opcodes[push_num].instruction.name

            if not_static:
                i += 1
                continue

            for push_num in range(num_pushes):
                args.append(opcodes[i - push_num - 1].arguments[0])
                del opcodes[i - push_num - 1]

            if not not_static:
                opcodes[i - num_pushes].arguments = args

            i += 1

    @staticmethod
    def num_bytes(i):
        return math.ceil(math.log(i + 1) / math.log(16) / 2)

    @staticmethod
    def __optimize_math(opcodes):
        i = 0
        while i < len(opcodes):
            equiv_func = opcodes[i].instruction.equivalent_function

            if opcodes[i].arguments and equiv_func and len(opcodes[i].arguments) == opcodes[i].instruction.removed:
                equiv = equiv_func(*opcodes[i].arguments) & (2 ** 256 - 1)
                push_num = Parser.num_bytes(equiv)
                op_code = hex(96 + push_num)[2:]
                opcodes[i] = Instruction(oc.get_opcode_by_code(
                    op_code), opcodes[i].address, [equiv])

            i += 1
