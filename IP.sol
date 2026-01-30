// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


/* 
* @title: Subnet Masking
* @author: Tianchan Dong & Damiche Ines
* @notice: This contract illustrate how IP addresses are distributed and calculated
* @notice: This contract has no sanity checks! Only use numbers provided in constructor
*/ 

contract Masking{

    // Return Variables
    string public Country;
    string public ISP;
    string public Institute;
    string public Device;

    // Maps of IP interpretation
    mapping(uint => string) public Countries;
    mapping(uint => string) public ISPs;
    mapping(uint => string) public Institutions;
    mapping(uint => string) public Devices;

    constructor() {
        Countries[34] = "Botswana";
        Countries[58] = "Egypt";
        Countries[125] = "Brazil";
        Countries[148] = "USA";
        Countries[152] = "France";
        Countries[196] = "Singapore";
        ISPs[20] = "Orange";
        ISPs[47] = "Telkom";
        ISPs[139] = "Vodafone";
        Institutions[89] = "University";
        Institutions[167] = "Government";
        Institutions[236] = "HomeNet";
        Devices[13] = "iOS";
        Devices[124] = "Windows";
        Devices[87] = "Android";
        Devices[179] = "Tesla ECU";
    }

    function IP(string memory input) public {
        bytes memory b = bytes(input);

        // 1) Convert the 32-character string into a 32-bit number
        uint ip = 0;
        for (uint i = 0; i < b.length; i++) {
            ip = ip << 1; // make room for the next bit

            // if the current character is '1', add 1
            if (b[i] == bytes1("1")) {
                ip = ip | 1;
            }
            // if it's '0', do nothing (bit stays 0)
        }

        // 2) Mask and shift to extract each 8-bit section
        uint mask = 0xFF; // 11111111 in binary (8 ones)

        uint countryCode = (ip >> 24) & mask;
        uint ispCode     = (ip >> 16) & mask;
        uint instCode    = (ip >> 8)  & mask;
        uint deviceCode  =  ip        & mask;

        // 3) Use the mappings to turn codes into text labels
        Country   = Countries[countryCode];
        ISP       = ISPs[ispCode];
        Institute = Institutions[instCode];
        Device    = Devices[deviceCode];
}
}