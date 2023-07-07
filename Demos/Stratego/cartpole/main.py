import argparse
import numpy as np
import gymnasium as gym

from tqdm import tqdm
from stratetrees.models import QTree


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--strategy', '-s', type=str,
        help='Path to the json file containing the UPPAAL Stratego strategy'
    )
    parser.add_argument(
        '--epochs', '-e', type=int, default=1000,
        help='Number of epochs to run'
    )
    return parser.parse_args()


if __name__ == '__main__':
    args = parse_args()
    model = QTree(args.strategy)

    env = gym.make('CartPole-v1')

    print(f'Evaluating {args.strategy} on {args.epochs} episodes')

    rewards = []
    for epoch in tqdm(range(args.epochs)):

        obs, info = env.reset()
        epoch_reward = 0

        done, trunc = False, False
        while not (done or trunc):

            action = model.predict(obs)
            obs, reward, done, trunc, info = env.step(action)

            epoch_reward += reward

        rewards.append(epoch_reward)

    print()
    print('Mean score: {} (+/- {})'.format(
        np.round(np.mean(rewards), 2),
        np.round(np.std(rewards), 2)
    ))
    print('(perfect score is 500)')
    print()
