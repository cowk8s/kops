package main

import (
	"io"

	"github.com/cowk8s/kops/cmd/kops/util"
	"github.com/spf13/cobra"
)

type GetOptions struct {
	ClusterName string
	Output      string
}

const (
	OutputYaml  = "yaml"
	OutputTable = "table"
	OutputJSON  = "json"
)

func NewCmdGet(f *util.Factory, out io.Writer) *cobra.Command {
	options := &GetOptions{
		Output: OutputTable,
	}

	cmd := &cobra.Command{
		Use:        "get",
		SuggestFor: []string{"list"},
	}

	cmd.PersistentFlags().StringVarP(&options.Output, "output", "o", options.Output, "output format. One of: table, yaml, json")
	cmd.RegisterFlagCompletionFunc("output", func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		return []string{OutputTable, OutputJSON, OutputYaml}, cobra.ShellCompDirectiveNoFileComp
	})

	cmd.AddCommand()

	return cmd
}
