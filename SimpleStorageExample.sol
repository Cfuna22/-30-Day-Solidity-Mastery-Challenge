// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.4.16 <0.9.0;

contract simpleStorage {
    uint storeData;

    function set(uint x)  public {
        storeData = x;
    }

    function get() public view  returns (uint) {
        return storeData;
    }
}