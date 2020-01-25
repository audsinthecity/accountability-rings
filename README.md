# Accountability Rings

A decentralized application built with Solidity for the Ethereum Blockchain. It allows users to create and join accountability rings so that they are able to incentivize themselves to accomplish longer term goals that can be hard to accomplish due to short term temptations. This application was created as a final project for the [Consensys Developer Bootcamp](https://consensys.net/academy/bootcamp/) and is comprised of a web app front end and several Solidity smart contracts.

## Inspiration
It is hard to form new habits. In the famous [Stanford Marshmallow Experiment](https://en.wikipedia.org/wiki/Stanford_marshmallow_experiment), it is shown that children who are able to delay gratification also have better outcomes in life - from higher income to lower BMI to higher educational attainment. However, [willpower is weak](https://www.vox.com/science-and-health/2018/1/15/16863374/willpower-overrated-self-control-psychology) and our brains evolved to [value short term gain over long term threats](https://news.stanford.edu/features/2015/decisions/evolution.html).

So how do we achieve our longer term goals with less effort and higher success? Incentivization may help here - in the form of a monetary stake and in the form of social peer pressure. On average, it takes [66 days](https://jamesclear.com/new-habit) to form a new habit, with a wide variance. For ease of remembering, accountability rings last for 8 weeks. This initial version will have proof submission and voting once per week for simplicity. A future version could require daily proof to better ingrain the accountability feedback loop. Rings can be used to ramp up an exercise routine, promote daily food journaling or meditation, build a saving habit, or more.

There are forms of this that already exist but some rely on the user to honestly self-report and be accountable to themselves, which may not be enough to get someone to form a better habit - it's too easy to come up with excuses and rationalize. Other apps let the user designate a judge and the user's money gets taken away if the judge says the user didn't perform. I don't know about you, but I think I have better things to do than monitor a friend's or spouse's exercise habits. With decentralized rings, each member is trying to accomplish the same goal and so are more motivated to serve as judges for each other.

## Rules
* Anyone can propose a new ring and must detail in their creation listing:
  * name
  * description
  * proof submission criteria in picture format
  * stake required in gwei
* Rings must be 6 people to ensure that there is always a majority when voting on a member's proof and that each member is not overburdened with proof checking
* Each ring member, including the proposer, must stake to join the ring
* Each new proposed ring has 3 days to reach the number of participants required. If any ring does not reach the required number of members, stakes are returned to all participants and the ring does not launch
* Once a ring is active, each member must submit a proof each week for 8 weeks total. The proof deadline is weekly, 5 days after ring creation
* Each active ring member must vote on the validity of other members' proof submissions within each week's time (7 days)
* If you do not submit proof on time or your proof is voted to be insufficient (majority rules), your stake is taken away and sent to the ring pool and your membership becomes deactivated. If you do not submit your votes on time, your stake is taken away and sent to the ring pool and your membership becomes deactivated
* In the event of a tie (ie 1 member has been deactivated and 2 vote valid and 2 vote invalid), valid is the default outcome
* Exactly 8 weeks after the launch of the ring, stakes for any remaining active members are returned and the ring pool is divided amongst remaining members less a 2% vig

## Features
* User can create a new accountability ring with name, description, proof of criteria description, and stake amount
* Other users can join a ring if there is space and if they submit the correct stake amount during the 3 day collection period after a new ring has been proposed
* Each ring member can submit proof of compliance each week before the deadline
* Each ring member can vote on the validity of other members' proofs each week before the deadline
* At the end of 8 weeks, stakes are returned to remaining active members and the ring pool is divided amongst remaining members less a 2% vig

## Demo

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* Install [Node.js v8+ LTS and npm](https://nodejs.org/en/) (comes with Node)
* Install [Truffle](https://www.trufflesuite.com/docs/truffle/getting-started/installation) or use the following command to do so
```
npm install -g truffle
```
* Install [Ganache](https://www.trufflesuite.com/ganache), a personal blockchain for Ethereum development you can use to deploy contracts, develop applications, and run tests
* Install [Metamask](www.metamask.io) extension on web browser (Chrome recommended, there are some issues using Brave and Firefox)
* Clone project

The directory structure is similar to any Truffle project, consisting of:
* contracts/: the Solidity source files for our smart contracts
* migrations/: the migration system to handle smart contract deployments
* test/: Solidity tests for the smart contracts
* truffle-config.js: Truffle configuration file

### Installing

Clone repository, as noted in the prerequisites.
Start a development blockchain by running
```
truffle develop
```
from the terminal in the project directory.
From the truffle console, compile and migrate by running
```
compile
```
and
```
migrate
```

## Running the tests

Still in the truffle console, you can run the pre-written tests by running
```
test
```

## Using the dapp

Start a local web server to use the dapp. We are using the `lite-server` library to serve our static files.
To start the local web server:
```
npm run dev
```
The page will automatically load in the browser, alternatively you can point your browser to `http://localhost:3000/`.
Metamask will also automatically open and request your login details in order to interact with the dapp.

## Built With

* [Solidity](https://solidity.readthedocs.io/en/v0.6.1/) - object-oriented, high-level language for implementing smart contracts
* [lite-server](https://www.npmjs.com/package/lite-server) - lightweight development only server that serves a web app, opens it in the browser, refreshes when html or javascript change, injects CSS changes using sockets, and has a fallback
page when a route is not found

## Future Extensions
* Use IPFS to upload picture proofs for more decentralization
* Add an option to contest a majority vote by submitting to [Kleros.io](https://kleros.io/en/), which would be the final arbiter (to protect against collusion of a majority in a ring to wrongfully take stakes from other members). There would be a penalty to the voters who voted invalid if a Kleros jury overturned the decision
* Add an option to select a charity at the formation of a ring and automatically send funds to the charity instead of dividing the ending pool balance, potentially one of these that [accept crypto](https://blog.wetrust.io/12-nonprofits-that-accept-cryptocurrency-504e4285622b). Also the option to select an anti-charity (a charity that you don't support, so that
losing the money is even more painful)
* Include the option to set a different number of members for each ring
* Include the option to vary the length of time a ring is in force
* Submit proof and/or vote on proofs more or less frequently than once per week
* Add other methods besides a picture for submitting proof, investigate oracles and API integrations (FitBit, MyFitnessPal, Mint, etc)?
* Change submission deadlines to a uniform time (such as 0000 UTC) so there is less potential user confusion around deadline times
* Add messaging so that ring members can share motivational tips, challenges, etc
* Automatic push notification reminder option
* Gamification - points or ERC-721 collectible badges to show progress, for social proof, or to win sponsor coupons (for example, Under Armour rewards MyFitnessPal logging with money saving coupons)
* Use zero knowledge proofs to prove that a submitted proof is valid without releasing actual data which may be sensitive (for instance, that someone reached the goal of saving $100 to an account last month without releasing the account balance,
banking institution, or account name)
* UI and design improvements
* Consider "earning back" your stake as time passes so there is immediate monetary reward for persisting, could be better psychologically
* Add scientifically proven tips and hacks to help people achieve goals- such as tips to decrease friction for desirable behaviors/increase friction for undesirable behaviors, attach a desirable behavior to an action already part of your routine, etc. Consider material from this [Hidden Brain](https://www.npr.org/2019/12/11/787160734/creatures-of-habit-how-habits-shape-who-we-are-and-who-we-become) episode on habit formation

## Authors

* **Audrey Chaing** - *Initial work* - [audsinthecity](https://github.com/audsinthecity)

## License

This project is licensed under GNU General Public License, version 3 (GPLv3) - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thanks to the Consensys Academy mentors; including Coogan Brennan, Luiz Crus, and especially Josh Crites; for being available via Slack/Zoom for questions, putting together the material, and organizing interesting guest lecturers
* Additional thanks to Bootcamp alumni mentors for answering questions on Slack and also being available for Zoom calls
* Nod to [PurpleBooth](https:github.com/PurpleBooth) for the README starting template

