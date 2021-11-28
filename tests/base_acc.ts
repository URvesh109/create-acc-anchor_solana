import * as anchor from '@project-serum/anchor';
import { Program } from '@project-serum/anchor';
import { BaseAcc } from '../target/types/base_acc';
const { SystemProgram } = anchor.web3;

describe('base_acc', () => {

  // Configure the client to use the local cluster.
  const provider = anchor.Provider.env();
  anchor.setProvider(provider);

  const program = anchor.workspace.BaseAcc as Program<BaseAcc>;

  it("Creates and initializes an account", async () => {

    // The Account to create.
    const myAccount = anchor.web3.Keypair.generate();

    // Create the new account and initialize it with the program.
    // #region code-simplified
    const tx = await program.rpc.initialize(provider.wallet.publicKey, {
      accounts: {
        myAccount: myAccount.publicKey,
        user: provider.wallet.publicKey,
        systemProgram: SystemProgram.programId,
      },
      signers: [myAccount],
    });
    // #endregion code-simplified

    // Fetch the newly created account from the cluster.
    // const account = await program.account.myAccount.fetch(myAccount.publicKey);

    console.log("Your transaction signature", tx);
    // Check it's state was initialized.
    // assert.ok(account.data.eq(new anchor.BN(1234)));

    // Store the account for the next test.
    // _myAccount = myAccount;
  });
});
