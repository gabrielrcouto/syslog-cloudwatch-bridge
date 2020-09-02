你好！
很冒昧用这样的方式来和你沟通，如有打扰请忽略我的提交哈。我是光年实验室（gnlab.com）的HR，在招Golang开发工程师，我们是一个技术型团队，技术氛围非常好。全职和兼职都可以，不过最好是全职，工作地点杭州。
我们公司是做流量增长的，Golang负责开发SAAS平台的应用，我们做的很多应用是全新的，工作非常有挑战也很有意思，是国内很多大厂的顾问。
如果有兴趣的话加我微信：13515810775  ，也可以访问 https://gnlab.com/，联系客服转发给HR。
# Syslog CloudWatch Logs bridge

This is a Syslog server that sends all logs received over to [AWS's CloudWatch Logs](https://aws.amazon.com/cloudwatch/details/#log-monitoring).

**Features:**

* Uses AWS's SDK to get credentials from the environment, credentials file or IAM Role.
* TCP and UDP Syslog server on a configurable port (default `514`).
* Automatic support for syslog messages in RFC3164, RFC6587 or RFC5424 formats.
* Configurable CloudWatch Log Group.
* Creates a new CloudWatch Log Stream on each invocation which is persisted runtime of the server.
* Dockerized in a minimal container (~8MB).


## Usage Example

1. Create an IAM user that can create Log Streams and Logs e.g.

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
      ],
        "Resource": [
          "arn:aws:logs:*:*:*"
      ]
    }
   ]
  }
  ```

2. Run the bridge

  ```
  $ docker run -e \
     AWS_REGION=ap-southeast-2 \
     AWS_ACCESS_KEY_ID=foo \
     AWS_SECRET_ACCESS_KEY=bar \
     LOG_GROUP_NAME=test-logger \
     -p 5014:514 \
     -p 5014:514/udp \
     rjocoleman/syslog-cloudwatch-bridge
  ```

3. Send syslog messages to `127.0.0.1:5014`, these will be viewable in your AWS CloudWatch Logs Management console under the group called `test-logger`.

## Troubleshooting

Issues with AWS signatures - as per #1 this could be a clock sync issue. You should add timezone to your container (as a volume) `/etc/timezone:/etc/timezone:ro`
