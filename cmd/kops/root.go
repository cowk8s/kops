package main

import (
	goflag "flag"
	"os"

	"github.com/spf13/cobra"
	"k8s.io/kubectl/pkg/util/i18n"
	"k8s.io/kubectl/pkg/util/templates"
)

var (
	rootLong = templates.LongDesc(i18n.T(`
	kOps is Kubernetes Operations.

	kOps is the easiest way to get a production grade Kubernetes cluster up and running.
	We like to think of it as kubectl for clusters.
	`))

	rootShort = i18n.T(`kOps is Kubernetes Operations.`)
)

type RootCmd struct {
	cobraCommand *cobra.Command
}

var rootCommand = RootCmd{
	cobraCommand: &cobra.Command{
		Use:   "kops",
		Short: rootShort,
		Long:  rootLong,
	},
}

func Execute() {
	goflag.Set("logtostderr", "true")
	goflag.CommandLine.Parse([]string{})
	if err := rootCommand.cobraCommand.Execute(); err != nil {
		os.Exit(1)
	}
}


