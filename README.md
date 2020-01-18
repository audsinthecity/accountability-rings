# Accountability Rings

A decentralized application built with Solidity for the Ethereum Blockchain. It allows users to create and join accountability rings so that they are able to incentivize themselves to accomplish longer term goals that can be hard to accomplish due to short term temptations. This application was created as a final project for the [Consensys Developer Bootcamp](https://consensys.net/academy/bootcamp/) and is comprised of a web app front end and several Solidity smart contracts.

## Inspiration
It is hard to form new habits. In the famous [Stanford Marshmallow Experiment](https://en.wikipedia.org/wiki/Stanford_marshmallow_experiment), it is shown that children who are able to delay gratification also have better outcomes in life - from higher income to lower BMI to higher educational attainment. However, [willpower is weak](https://www.vox.com/science-and-health/2018/1/15/16863374/willpower-overrated-self-control-psychology) and our brains evolved to [value short term gain over long term threats](https://news.stanford.edu/features/2015/decisions/evolution.html).

So how do we achieve our longer term goals with less effort and higher success? Incentivization may help here - in the form of a monetary stake and in the form of social peer pressure. On average, it takes [66 days](https://jamesclear.com/new-habit) to form a new habit so accountability rings last for 66 days. Rings can be used to ramp up an exercise routine, promote daily food journaling or meditation, build a saving habit, or more.

## Rules
* Anyone can propose a new ring and must detail in their creation listing:
  * proof submission criteria
  * number of people
  * stake required
* Rings must be 6, 8, or 10 people to ensure that there is always a majority when voting on a member's proof and that each member is not overburdened with proof checking
* Each ring member, including the proposer, must stake to join the ring
* Each new proposed ring has until 0000 UTC each Monday to reach the number of participants required. If any ring does not reach the required number of members, stakes are returned to all participants and the ring does not launch
* Once a ring is active, each member has until 0000 UTC Fridays to submit their proof
* Each active ring member must vote on the validity of other members' proof submissions by 0000 UTC Mondays
* If you you not submit proof on time or your proof is voted to be insufficient (majority rules), your stake is taken away and sent to the ring pool. If you do not submit your votes on time, your stake is taken away and sent to the ring pool
* At 0000 UTC 66 days after the launch of the ring, stakes for any remaining members are returned and the ring pool is divided amongst remaining members less a 2% vig

## Features
* User can create new accountability ring with criteria, group size, and stake amount
* Other users can join a ring if there is space and if they submit the correct stake amount until the following 0000 UTC Monday
* Each ring member can submit proof of compliance
* Each ring member can vote on the validity of other members' proof

## Demo

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

* Install [NodeJS](https://nodejs.org/en/)
* Install [Truffle](https://www.trufflesuite.com/docs/truffle/getting-started/installation)
* Install GanacheCLI
* Install [Metamask](www.metamask.io) on web browser (Chrome recommended)
* Clone project

```
Give examples
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Launch private blockchain with Ganache
```
ganache-cli
```
Launch tests
``` cd test-dir
truffle test
```

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Future Extensions
* Add an option to contest a majority vote by submitting to Kleros.io, which would be the final arbiter
* Add an option to name a charity at the formation of a ring and automatically send funds to the charity instead of diving the ending pool balance

## Authors

* **Audrey Chaing** - *Initial work* - [audsinthecity](https://github.com/audsinthecity)

## License

This project is licensed under GNU General Public License, version 3 (GPLv3) - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thanks to [PurpleBooth](https:github.com/PurpleBooth) for the README starting template
* etc
