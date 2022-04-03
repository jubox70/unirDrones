// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library DataLibrary {

    enum Pesticidas { A, B, C, D, E }

    struct Dron {
        uint256 alturaMaxima;
        uint256 alturaMinima;
        uint256 coste;
        Pesticidas pesticidaAceptado;

    }

    struct Parcela {
        uint256 alturaMaxima;
        uint256 alturaMinima;
        Pesticidas pesticidaAceptado;

    }
}