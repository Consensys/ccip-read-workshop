import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import hre from "hardhat";

const VeraxFetcherModule = buildModule("VeraxFetcherModule", (m) => {
  const networkName = hre.network.name;

  let verifierAddress: string;
  let targetAddress: string;

  switch (networkName) {
    case "sepolia":
    case "localhost":
      // WARNING if deploying on localhost you'll need to do your tests on a sepolia forked chain
      verifierAddress = "0x17289b2e80DcaB38249adb5a2Bd1a0cAF12361A0";
      targetAddress = "0xDaf3C3632327343f7df0Baad2dc9144fa4e1001F";
      break;
    default:
      throw "Network not supported";
  }

  const veraxFetcher = m.contract("VeraxFetcher", [
    verifierAddress,
    targetAddress,
  ]);

  return { veraxFetcher };
});

export default VeraxFetcherModule;
