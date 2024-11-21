
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Test, console} from "forge-std/Test.sol";
import {DisasterReliefFund} from "../src/DisasterReliefFund.sol";

contract DisasterReliefFundTest is Test {
    DisasterReliefFund public fund;

    // Set up the contract
    function setUp() public {
        fund = new DisasterReliefFund();
    }


// Test case for createProposal function
function testCreateProposal() public {
    string memory title = "Disaster Relief for Earthquake";
    string memory description = "This proposal is for raising funds to help with earthquake relief efforts.";
    uint64 votingDeadline = uint64(block.timestamp + 1 days); // Set deadline for 1 day from now

    uint256 proposalId = fund.createProposal(title, description, votingDeadline);

    // Assert that the proposal count is 1 (since it's the first proposal)
    uint256 expectedProposalCount = 1;
    assertEq(fund.proposalCount(), expectedProposalCount, "Proposal count should be 1");

    // Access the components directly
    (
        uint256 id,
        address proposer,
        string memory titleFromStorage,
        string memory descriptionFromStorage,
        uint256 votesFor,
        uint256 votesAgainst,
        uint64 votingDeadlineFromStorage,
        uint256 fundsReceived,
        uint256 overallFundsReceived,
        bool executed,
        bool archived,
        bool votingPassed,
        uint64 dateCreated
    ) = fund.proposals(proposalId);

    // Assert that the proposal has been created correctly
    assertEq(id, proposalId, "Proposal ID should match");
    assertEq(titleFromStorage, title, "Proposal title should match");
    assertEq(descriptionFromStorage, description, "Proposal description should match");
    assertEq(votingDeadlineFromStorage, votingDeadline, "Proposal voting deadline should match");
    assertEq(proposer, address(this), "Proposal proposer should match the sender's address");
}
}