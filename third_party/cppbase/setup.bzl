"""Base C++ environment with Abseil or Boost and unit testing library."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@rules_foreign_cc//:workspace_definitions.bzl", "rules_foreign_cc_dependencies")


def setup_cppbase():
    setup_absl()
    setup_googletest()
    setup_decimal()


def setup_absl():
    rules_foreign_cc_dependencies()

    # Abseil
    if not native.existing_rule("com_google_absl"):
        # How to update:
        # Abseil generally just does daily (or even subdaily) releases. None are
        # special, so just periodically update as necessary.
        #
        #  https://github.com/abseil/abseil-cpp/commits/master
        #  pick a recent release.
        #  Hit the 'clipboard with a left arrow' icon to copy the commit hex
        #
        # 2020-05-08
        http_archive(
            name = "com_google_absl",
            urls = [
"https://github.com/abseil/abseil-cpp/archive/6f9d96a1f41439ac172ee2ef7ccd8edf0e5d068c.tar.gz",
            ],
            sha256 = "62c27e7a633e965a2f40ff16b487c3b778eae440bab64cad83b34ef1cbe3aa93",
            strip_prefix = "abseil-cpp-6f9d96a1f41439ac172ee2ef7ccd8edf0e5d068c",
        )


def setup_googletest():
    # GoogleTest/GoogleMock framework. Used by most unit-tests.
    if not native.existing_rule("com_google_googletest"):
        # How to update:
        # Googletest generally just does daily (or even subdaily) releases along
        # with occasional numbered releases.
        #
        #  https://github.com/google/googletest/commits/master
        #  pick a recent release.
        #  Hit the 'clipboard with a left arrow' icon to copy the commit hex
        # 2020-05-05
        http_archive(
            name = "com_google_googletest",
            url = "https://github.com/google/googletest/archive/0eea2e9fc63461761dea5f2f517bd6af2ca024fa.tar.gz",
            sha256 = "552f1b59b8332195ae257b01182101dc93a3a16c3f808e763af9a1c3e4b1756a",
            strip_prefix = "googletest-0eea2e9fc63461761dea5f2f517bd6af2ca024fa",
        )


def setup_decimal():
    # GoogleTest/GoogleMock framework. Used by most unit-tests.
    if not native.existing_rule("mpdecimal"):
        # 2020-07-25
        http_archive(
            name = "mpdecimal",
            url = "http://www.bytereef.org/software/mpdecimal/releases/mpdecimal-2.5.0.tar.gz",
            sha256 = "15417edc8e12a57d1d9d75fa7e3f22b158a3b98f44db9d694cfd2acde8dfa0ca",
            strip_prefix = "mpdecimal-2.5.0",
            build_file = "//third_party/cppbase:mpdecimal.BUILD",
        )
