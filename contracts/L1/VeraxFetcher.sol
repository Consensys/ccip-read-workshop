// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {EVMFetcher} from "@consensys/linea-state-verifier/contracts/EVMFetcher.sol";
import {EVMFetchTarget} from "@consensys/linea-state-verifier/contracts/EVMFetchTarget.sol";
import {IEVMVerifier} from "@consensys/linea-state-verifier/contracts/IEVMVerifier.sol";

contract VeraxFetcher is EVMFetchTarget {
    using EVMFetcher for EVMFetcher.EVMFetchRequest;

    uint256 constant ACCEPTED_L2_BLOCK_RANGE_LENGTH = 86400;
    uint256 constant ATTESTATIONS_SLOT = 102;

    IEVMVerifier verifier;
    address target;

    constructor(IEVMVerifier _verifier, address _target) {
        verifier = _verifier;
        target = _target;
    }

    /**
     * @dev inherits from EVMFetchTarget
     */
    function getAcceptedL2BlockRangeLength()
        public
        pure
        override
        returns (uint256)
    {
        return ACCEPTED_L2_BLOCK_RANGE_LENGTH;
    }

    function getAttestation(
        bytes32 attestationId
    ) public view returns (bytes memory) {
        EVMFetcher
            .newFetchRequest(verifier, target)
            .getStatic(ATTESTATIONS_SLOT)
            .element(attestationId)
            .fetch(this.getAttestationCallback.selector, "");
    }

    function getAttestationCallback(
        bytes[] memory values,
        bytes memory
    ) public pure returns (bytes memory) {
        return values[0];
    }
}
