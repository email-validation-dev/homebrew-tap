# email-validation: validate email addresses and lists with the email-validation.org API.
# Installs the npm package @email-validation/cli; `url` and `sha256` name one release's tarball.
class EmailValidation < Formula
  desc "Validate email addresses and lists with the email-validation.org API"
  homepage "https://email-validation.org/"
  url "https://registry.npmjs.org/@email-validation/cli/-/cli-1.0.0.tgz"
  sha256 "143643de333b741faa7caffc224d2b3489f89bee59c1a6d14332bfdb1082a650"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match "email-validation #{version}", shell_output("#{bin}/email-validation --version")
    # Without a key the tool stops before any request, with exit code 2 (usage error): no network in the test.
    output = shell_output("env -u EV_API_KEY #{bin}/email-validation credits 2>&1", 2)
    assert_match "Set EV_API_KEY", output
  end
end
