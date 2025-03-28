# what is this?

This is an example angular 19 app that shows how to inject configuration at runtime instead of the antiquated angular environment file process that requires things to be hard-coded. This allows us to follow good CI practices and have ONE build pipeline that produces an artifact that can be deployed in any environment because it can get its configuration at runtime.

### How it works.

In the public folder we have two files, env.js and env.template.js. These files are IIFEs that inject values into the global window. env.js is simply there for running locally
with `npm start`. env.template.js is the magic. That file contains a well-known value for all environment variables we need to dynamically set at run time. They need to be unique and well-known. These files need to be in public because files in there don't get transpiled or anything. There is a hook in index.html that loads this file too.

You will need the standard production and development angular environment files that get generated when you run the environment command. In these files you simply need to return an object where the values are pulled from window.

The Dockerfile has a custom entrypoint. This shell script is responsible for doing a find and replace in the template file for all the well-known keys and replacing them with the right values. It then moves the template file over the env.js file. Then the application starts up and our values are available as expected.

Application code just references environment stuff like normal.
