#!/usr/bin/python
# Copyright (C) 2015-2018 Free Software Foundation, Inc.
# This file is part of the GNU C Library.
#
# The GNU C Library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# The GNU C Library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with the GNU C Library; if not, see
# <http://www.gnu.org/licenses/>.
"""Compare two benchmark results

Given two benchmark result files and a threshold, this script compares the
benchmark results and flags differences in performance beyond a given
threshold.
"""
import sys
import os
import pylab
import import_bench as bench

def do_compare(func, var, tl1, tl2, par, threshold):
    """Compare one of the aggregate measurements

    Helper function to compare one of the aggregate measurements of a function
    variant.

    Args:
        func: Function name
        var: Function variant name
        tl1: The first timings list
        tl2: The second timings list
        par: The aggregate to measure
        threshold: The threshold for differences, beyond which the script should
        print a warning.
    """
    d = abs(tl2[par] - tl1[par]) * 100 / tl1[str(par)]
    if d > threshold:
        if tl1[par] > tl2[par]:
            ind = '+++'
        else:
            ind = '---'
        print('%s %s(%s)[%s]: (%.2lf%%) from %g to %g' %
                (ind, func, var, par, d, tl1[par], tl2[par]))


def compare_runs(pts1, pts2, threshold):
    """Compare two benchmark runs

    Args:
        pts1: Timing data from first machine
        pts2: Timing data from second machine
    """

    # XXX We assume that the two benchmarks have identical functions and
    # variants.  We cannot compare two benchmarks that may have different
    # functions or variants.  Maybe that is something for the future.
    for func in pts1['functions'].keys():
        for var in pts1['functions'][func].keys():
            tl1 = pts1['functions'][func][var]
            tl2 = pts2['functions'][func][var]

            # Compare the consolidated numbers
            # do_compare(func, var, tl1, tl2, 'max', threshold)
            do_compare(func, var, tl1, tl2, 'min', threshold)
            do_compare(func, var, tl1, tl2, 'mean', threshold)

            # Skip over to the next variant or function if there is no detailed
            # timing info for the function variant.
            if 'timings' not in pts1['functions'][func][var].keys() or \
                'timings' not in pts2['functions'][func][var].keys():
                    return

            # If two lists do not have the same length then it is likely that
            # the performance characteristics of the function have changed.
            # XXX: It is also likely that there was some measurement that
            # strayed outside the usual range.  Such ouiers should not
            # happen on an idle machine with identical hardware and
            # configuration, but ideal environments are hard to come by.
            if len(tl1['timings']) != len(tl2['timings']):
                print('* %s(%s): Timing characteristics changed' %
                        (func, var))
                print('\tBefore: [%s]' %
                        ', '.join([str(x) for x in tl1['timings']]))
                print('\tAfter: [%s]' %
                        ', '.join([str(x) for x in tl2['timings']]))
                continue

            # Collect numbers whose differences cross the threshold we have
            # set.
            issues = [(x, y) for x, y in zip(tl1['timings'], tl2['timings']) \
                        if abs(y - x) * 100 / x > threshold]

            # Now print them.
            for t1, t2 in issues:
                d = abs(t2 - t1) * 100 / t1
                if t2 > t1:
                    ind = '-'
                else:
                    ind = '+'

                print("%s %s(%s): (%.2lf%%) from %g to %g" %
                        (ind, func, var, d, t1, t2))


def plot_graphs(bench1, bench2):
    """Plot graphs for functions

    Make scatter plots for the functions and their variants.

    Args:
        bench1: Set of points from the first machine
        bench2: Set of points from the second machine.
    """
    for func in bench1['functions'].keys():
        for var in bench1['functions'][func].keys():
            # No point trying to print a graph if there are no detailed
            # timings.
            if u'timings' not in bench1['functions'][func][var].keys():
                print('Skipping graph for %s(%s)' % (func, var))
                continue

            pylab.clf()
            pylab.ylabel('Time (cycles)')

            # First set of points
            length = len(bench1['functions'][func][var]['timings'])
            X = [float(x) for x in range(length)]
            lines = pylab.scatter(X, bench1['functions'][func][var]['timings'],
                    1.5 + 100 / length)
            pylab.setp(lines, 'color', 'r')

            # Second set of points
            length = len(bench2['functions'][func][var]['timings'])
            X = [float(x) for x in range(length)]
            lines = pylab.scatter(X, bench2['functions'][func][var]['timings'],
                    1.5 + 100 / length)
            pylab.setp(lines, 'color', 'g')

            if var:
                filename = "%s-%s.png" % (func, var)
            else:
                filename = "%s.png" % func
            print('Writing out %s' % filename)
            pylab.savefig(filename)


def main(args):
    """Program Entry Point

    Take two benchmark output files and compare their timings.
    """
    if len(args) > 4 or len(args) < 3:
        print('Usage: %s <schema> <file1> <file2> [threshold in %%]' % sys.argv[0])
        sys.exit(os.EX_USAGE)

    bench1 = bench.parse_bench(args[1], args[0])
    bench2 = bench.parse_bench(args[2], args[0])
    if len(args) == 4:
        threshold = float(args[3])
    else:
        threshold = 10.0

    if (bench1['timing_type'] != bench2['timing_type']):
        print('Cannot compare benchmark outputs: timing types are different')
        return

    plot_graphs(bench1, bench2)

    bench.compress_timings(bench1)
    bench.compress_timings(bench2)

    compare_runs(bench1, bench2, threshold)


if __name__ == '__main__':
    main(sys.argv[1:])
