#!/usr/bin/env fish
set -l test_count 12
function shark.test.1
  echo -n " Shows help with no argv or -h\* option"
  ./shark | grep -q USAGE
    and ./shark -h | grep -q USAGE
      and ./shark --help | grep -q USAGE
end
function shark.test.2
  echo -n " Charts piped data"
  test (echo 0,30,55,80,33,150 | ./shark) = ▁▂▃▄▂█
  and test (printf "%s\n" 0,30,55,80,33,150 | ./shark) = ▁▂▃▄▂█
  and test (printf "%s\n\n" ,,0,,30,,55,,80,,33,,150, | ./shark) = ▁▂▃▄▂█
end
function shark.test.3
  echo -n " Charts argv data"
  test (./shark 1,5,22,13,5 ▁▂█▅▂)
end
function shark.test.4
  echo -n " Charts way spaced data"
  test (./shark 0 30               55 80 33     150) = ▁▂▃▄▂█
end
function shark.test.5
  echo -n " Handles decimals"
  test (./shark 5.5,20) = ▁█
end
function shark.test.6
  echo -n " Charts 100 lt 300"
  test (./shark 1,2,3,4,100,5,10,20,50,300) = ▁▁▁▁▃▁▁▁▂█
end
function shark.test.7
  echo -n " Charts 50 lt 100"
  test (./shark 1,50,100) = ▁▄█
end
function shark.test.8
  echo -n " Charts 4 lt 8"
  test (./shark 2,4,8) = ▁▃█
end
function shark.test.9
  echo -n " Charts no tier 0"
  test (./shark 1,2,3,4,5) = ▁▂▄▆█
end
function shark.test.10
  echo -n " Equalizes at midtier on same data"
  test (./shark 1,1,1,1) = ▅▅▅▅
end
function shark.test.11
  echo -n " Charts data in irregular formats"
  test (./shark 2 4 8) = ▁▃█
    and test (./shark "// 2 // 4 // 8 //") = ▁▃█
      and test (./shark "_|_2_|_4_|_8_|_") = ▁▃█
        and test (./shark "~(2)~(4)~(8)~") = ▁▃█
end
function shark.test.12
  echo -n " Neutralizes negative numbers"
  test (./shark "[[10]]-[[5]]-[[-5]]-[[5]]-[[-5]]-[[5]]-[[-5]]-[[5]]-[[10]]") = █▅▁▅▁▅▁▅█
end
# Simple ad-hoc test run. Check terlar/fish-tank in the meantime for a
# more consistent unit test framework.
echo (set_color 0f0)"Testing Shark..."
for index in (seq $test_count)
  set_color white
  eval shark.test.$index
    and echo (set_color -o 0f0) ✔(set_color normal)
    or echo (set_color -o f00) ✘(set_color normal)
end
