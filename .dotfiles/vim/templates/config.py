import sys
from pathlib import Path
from absl import flags
from ddi import utils

FLAGS = flags.FLAGS

flags.DEFINE_string('outdir', '', '')
flags.DEFINE_string('config', '', '')


def main(outdir, config):

    return


if __name__ == '__main__':
    _, *unparsed = flags.FLAGS(sys.argv, known_only=True)
    config = utils.load_config(FLAGS.config)
    update = utils.parse_config_updates(unparsed)
    config.update(update)

    outdir = Path(FLAGS.outdir)
    outdir.mkdir(exist_ok=True, parents=True)

    utils.dump_config(outdir/'config.yaml', config)
    utils.symlink_to_logfile(outdir/'log')

    main(outdir, config)
