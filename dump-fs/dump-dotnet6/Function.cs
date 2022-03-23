using System;
using System.Diagnostics;
using System.IO;
using System.Threading.Tasks;

using Amazon.Lambda.Core;
using Amazon;
using Amazon.S3;
using Amazon.S3.Model;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]

namespace dump_dotnet6
{
    public class Function
    {
        public async Task<string> FunctionHandler_x86_64(object invokeEvent, ILambdaContext context)
        {
            return await FunctionHandler(invokeEvent, context, "x86_64");
        }

        public async Task<string> FunctionHandler_arm64(object invokeEvent, ILambdaContext context)
        {
            return await FunctionHandler(invokeEvent, context, "arm64");
        }

        public async Task<string> FunctionHandler(object invokeEvent, ILambdaContext context, string arch)
        {
            string filename = $"dotnet6-{arch}.tgz";
            string cmd = $"touch /tmp/{filename} && tar -cpzf /tmp/{filename} --numeric-owner --ignore-failed-read /var/runtime /var/lang";

            Console.WriteLine($"invokeEvent: {invokeEvent}");
            Console.WriteLine($"context.RemainingTime: {context.RemainingTime}");

            Console.WriteLine("Parent cmdline:");
            Console.WriteLine(File.ReadAllText("/proc/1/cmdline").Replace("\0", " "));

            Console.WriteLine("Parent env:");
            RunShell("xargs --null --max-args=1 < /proc/1/environ");

            Console.WriteLine("This cmdline:");
            Console.WriteLine(File.ReadAllText($"/proc/{Process.GetCurrentProcess().Id}/cmdline").Replace("\0", " "));

            Console.WriteLine("This env:");
            RunShell($"xargs --null --max-args=1 < /proc/{Process.GetCurrentProcess().Id}/environ");

            Console.WriteLine($"Current working directory: {Directory.GetCurrentDirectory()}");

            RunShell(cmd);

            Console.WriteLine("Zipping done! Uploading...");

            var s3Client = new AmazonS3Client(RegionEndpoint.EUCentral1);
            var response = await s3Client.PutObjectAsync(new Amazon.S3.Model.PutObjectRequest
            {
                BucketName = "docker-lambda",
                Key = $"fs/{filename}",
                FilePath = $"/tmp/{filename}",
                CannedACL = S3CannedACL.PublicRead,
            });

            Console.WriteLine("Uploading done!");

            return response.HttpStatusCode.ToString();
        }

        private static Process RunShell(string cmd)
        {
            var escapedArgs = cmd.Replace("\"", "\\\"");
            var process = new Process
            {
                StartInfo = new ProcessStartInfo
                {
                    FileName = "/bin/sh",
                    Arguments = $"-c \"{escapedArgs}\"",
                    UseShellExecute = false,
                    CreateNoWindow = true,
                }
            };
            process.Start();
            process.WaitForExit();
            return process;
        }
    }
}
