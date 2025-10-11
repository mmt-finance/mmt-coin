module mmt::mmt;

use sui::coin;
use sui::url;

public struct MMT has drop {}

fun init(witness: MMT, ctx: &mut TxContext) {
    let name = b"MMT";
    let symbol = b"MMT";
    let decimals = 9;
    let description = b"MMT Token";
    let icon_url = url::new_unsafe_from_bytes(b"https://momentum-statics.s3.us-west-1.amazonaws.com/MMT.png");

    let (treasury_cap, deny_cap, token_metadata) = coin::create_regulated_currency_v2(
        witness,
        decimals,
        symbol,
        name,
        description,
        option::some(icon_url),
        true,
        ctx,
    );

    transfer::public_share_object(token_metadata);
    transfer::public_transfer(treasury_cap, ctx.sender());
    transfer::public_transfer(deny_cap, ctx.sender());
}
