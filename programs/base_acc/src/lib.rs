use anchor_lang::prelude::*;
use solana_program::msg;

declare_id!("7GscEKEx8NHT4HYzEgUTB99QtjXu7XFwRykvcw2pEpXK");

#[program]
mod base_acc {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>, user: Pubkey) -> ProgramResult {
        let my_account = &mut ctx.accounts.my_account;
        my_account.user = user;
        msg!("Hello World Rust program {:?}", my_account.user);
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize<'info> {
    #[account(init, payer = user, space = 8 + 32)]
    pub my_account: Account<'info, MyAccount>,
    #[account(mut)]
    pub user: Signer<'info>,
    pub system_program: Program<'info, System>,
}

#[account]
pub struct MyAccount {
    pub user: Pubkey,
}
