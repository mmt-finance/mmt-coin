module mmt::mmt;

use std::string;
use sui::coin_registry;

public struct MMT has drop {}

fun init(witness: MMT, ctx: &mut TxContext) {
    let name = string::utf8(b"MMT");
    let symbol = string::utf8(b"MMT");
    let decimals = 9;
    let description = string::utf8(
        b"MMT is the governance token for Momentum, the Move ecosystem’s liquidity engine that enables veMMT holders to steer protocol governance, liquidity allocation, and cross-chain ecosystem growth.",
    );
    let icon_url = string::utf8(b"https://momentum-statics.s3.us-west-1.amazonaws.com/MMT.png");

    let (currency, treasury_cap) = coin_registry::new_currency_with_otw(
        witness,
        decimals,
        symbol,
        name,
        description,
        icon_url,
        ctx,
    );

    let metadata_cap = currency.finalize(ctx);

    transfer::public_transfer(treasury_cap, ctx.sender());
    transfer::public_transfer(metadata_cap, ctx.sender());
}