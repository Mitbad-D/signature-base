
rule SUSP_Base64_Encoded_Hex_Encoded_Code {
   meta:
      author = "Florian Roth"
      description = "Detects hex encoded code that has been base64 encoded"
      date = "2019-04-29"
      score = 65
      reference = "https://www.nextron-systems.com/2019/04/29/spotlight-threat-hunting-yara-rule-example/"
   strings:
      $x1 = { 78 34 4e ?? ?? 63 65 44 ?? ?? 58 48 67 }
      $x2 = { 63 45 44 ?? ?? 58 48 67 ?? ?? ?? 78 34 4e }

      $fp1 = "Microsoft Azure Code Signp$"
   condition:
      1 of ($x*) and not 1 of ($fp*)
}

rule SUSP_Double_Base64_Encoded_Executable {
   meta:
      description = "Detects an executable that has been encoded with base64 twice"
      author = "Florian Roth"
      reference = "https://twitter.com/TweeterCyber/status/1189073238803877889"
      date = "2019-10-29"
      hash1 = "1a172d92638e6fdb2858dcca7a78d4b03c424b7f14be75c2fd479f59049bc5f9"
   strings:
      $ = "VFZwVEFRR" ascii wide
      $ = "RWcFRBUU" ascii wide
      $ = "UVnBUQVFF" ascii wide
      $ = "VFZvQUFBQ" ascii wide
      $ = "RWb0FBQU" ascii wide
      $ = "UVm9BQUFB" ascii wide
      $ = "VFZxQUFBR" ascii wide
      $ = "RWcUFBQU" ascii wide
      $ = "UVnFBQUFF" ascii wide
      $ = "VFZwUUFBS" ascii wide
      $ = "RWcFFBQU" ascii wide
      $ = "UVnBRQUFJ" ascii wide
      $ = "VFZxUUFBT" ascii wide
      $ = "RWcVFBQU" ascii wide
      $ = "UVnFRQUFN" ascii wide
   condition:
      1 of them
}

rule SUSP_Reversed_Base64_Encoded_EXE {
   meta:
      description = "Detects an base64 encoded executable with reversed characters"
      author = "Florian Roth"
      date = "2020-04-06"
      reference = "Internal Research"
      score = 80
      type = "file"
      hash1 = "7e6d9a5d3b26fd1af7d58be68f524c4c55285b78304a65ec43073b139c9407a8"
   strings:
      $s1 = "AEAAAAEQATpVT"
      $s2 = "AAAAAAAAAAoVT"
      $s3 = "AEAAAAEAAAqVT"
      $s4 = "AEAAAAIAAQpVT"
      $s5 = "AEAAAAMAAQqVT"

      $sh1 = "SZk9WbgM1TEBibpBib1JHIlJGI09mbuF2Yg0WYyd2byBHIzlGaU" ascii
      $sh2 = "LlR2btByUPREIulGIuVncgUmYgQ3bu5WYjBSbhJ3ZvJHcgMXaoR" ascii
      $sh3 = "uUGZv1GIT9ERg4Wag4WdyBSZiBCdv5mbhNGItFmcn9mcwBycphGV" ascii
   condition:
      filesize < 10000KB and 1 of them
}
