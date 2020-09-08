## Copyright (C) 2020 Andréas Livet
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} fft_one_sided_2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andréas Livet <dede@pc>
## Created: 2020-09-08

function [freq_power_components, frequencies, fft_len] = fft_one_sided (wave_data, sample_frequency)
  L = length (wave_data);
  NFFT = L;
  X = fft (wave_data, NFFT);
  ## Power of each freq components 
  freq_power_components = X .* conj (X) / (NFFT * L);
  freq_power_components = freq_power_components(1:NFFT/2);
  frequencies = sample_frequency * (0:NFFT / 2 - 1) / NFFT;
  fft_len = NFFT
endfunction