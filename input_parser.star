constants = import_module("./src/package_io/constants.star")

# The deployment process is divided into various stages.
# You can deploy the whole stack and then only deploy a subset of the components to perform an
# an upgrade or to test a new version of a component.
DEFAULT_DEPLOYMENT_STAGES = {
    # Deploy a local L1 chain using the ethereum-package.
    # Set to false to use an external L1 like Sepolia.
    # Note that it will require a few additional parameters.
    "deploy_l1": True,
    # Deploy zkevm contracts on L1 (as well as fund accounts).
    # Set to false to use pre-deployed zkevm contracts.
    # Note that it will require a few additional parameters.
    "deploy_zkevm_contracts_on_l1": True,
    # Deploy databases.
    "deploy_databases": True,
    # Deploy CDK central/trusted environment.
    "deploy_cdk_central_environment": True,
    # Deploy CDK bridge infrastructure.
    "deploy_cdk_bridge_infra": True,
    # Deploy the agglayer.
    "deploy_agglayer": True,
    # Deploy cdk-erigon node.
    # TODO: Remove this parameter to incorporate cdk-erigon inside the central environment.
    "deploy_cdk_erigon_node": True,
}

DEFAULT_IMAGES = {
    "agglayer_image": "ghcr.io/agglayer/agglayer:feature-storage-adding-epoch-packing",  # https://github.com/agglayer/agglayer/pkgs/container/agglayer-rs
    "cdk_erigon_node_image": "hermeznetwork/cdk-erigon:v2.1.0",  # https://hub.docker.com/r/hermeznetwork/cdk-erigon/tags
    "cdk_node_image": "ghcr.io/0xpolygon/cdk:0.3.1-rc1",  # https://github.com/0xpolygon/cdk/pkgs/container/cdk
    "cdk_validium_node_image": "0xpolygon/cdk-validium-node:0.7.0-cdk",  # https://hub.docker.com/r/0xpolygon/cdk-validium-node/tags
    "zkevm_bridge_proxy_image": "haproxy:3.0-bookworm",  # https://hub.docker.com/_/haproxy/tags
    "zkevm_bridge_service_image": "hermeznetwork/zkevm-bridge-service:v0.6.0-RC1",  # https://hub.docker.com/r/hermeznetwork/zkevm-bridge-service/tags
    "zkevm_bridge_ui_image": "leovct/zkevm-bridge-ui:multi-network-2",  # https://hub.docker.com/r/leovct/zkevm-bridge-ui/tags
    "zkevm_contracts_image": "leovct/zkevm-contracts:v8.0.0-rc.4-fork.12",  # https://hub.docker.com/repository/docker/leovct/zkevm-contracts/tags
    "zkevm_da_image": "0xpolygon/cdk-data-availability:0.0.10",  # https://hub.docker.com/r/0xpolygon/cdk-data-availability/tags
    "zkevm_node_image": "hermeznetwork/zkevm-node:v0.7.3",  # https://hub.docker.com/r/hermeznetwork/zkevm-node/tags
    "zkevm_pool_manager_image": "hermeznetwork/zkevm-pool-manager:v0.1.1",  # https://hub.docker.com/r/hermeznetwork/zkevm-pool-manager/tags
    "zkevm_prover_image": "hermeznetwork/zkevm-prover:v8.0.0-RC14-fork.12",  # https://hub.docker.com/r/hermeznetwork/zkevm-prover/tags
    "zkevm_sequence_sender_image": "hermeznetwork/zkevm-sequence-sender:v0.2.4",  # https://hub.docker.com/r/hermeznetwork/zkevm-sequence-sender/tags
}

DEFAULT_PORTS = {
    "agglayer_port": 4444,
    "agglayer_prover_port": 4445,
    "agglayer_metrics_port": 9092,
    "agglayer_prover_metrics_port": 9093,
    "prometheus_port": 9091,
    "zkevm_aggregator_port": 50081,
    "zkevm_bridge_grpc_port": 9090,
    "zkevm_bridge_rpc_port": 8080,
    "zkevm_bridge_ui_port": 80,
    "zkevm_dac_port": 8484,
    "zkevm_data_streamer_port": 6900,
    "zkevm_executor_port": 50071,
    "zkevm_hash_db_port": 50061,
    "zkevm_pool_manager_port": 8545,
    "zkevm_pprof_port": 6060,
    "zkevm_rpc_http_port": 8123,
    "zkevm_rpc_ws_port": 8133,
}

# Addresses and private keys of the different components.
# They have been generated using the following command:
# polycli wallet inspect --mnemonic 'lab code glass agree maid neutral vessel horror deny frequent favorite soft gate galaxy proof vintage once figure diary virtual scissors marble shrug drop' --addresses 9 | tee keys.txt | jq -r '.Addresses[] | [.ETHAddress, .HexPrivateKey] | @tsv' | awk 'BEGIN{split("sequencer,aggregator,claimtxmanager,timelock,admin,loadtest,agglayer,dac,proofsigner",roles,",")} {print "# " roles[NR] "\n\"zkevm_l2_" roles[NR] "_address\": \"" $1 "\","; print "\"zkevm_l2_" roles[NR] "_private_key\": \"0x" $2 "\",\n"}'
DEFAULT_ACCOUNTS = {
    # sequencer
    "zkevm_l2_sequencer_address": "0x5b06837A43bdC3dD9F114558DAf4B26ed49842Ed",
    "zkevm_l2_sequencer_private_key": "0x183c492d0ba156041a7f31a1b188958a7a22eebadca741a7fe64436092dc3181",
    # aggregator
    "zkevm_l2_aggregator_address": "0xCae5b68Ff783594bDe1b93cdE627c741722c4D4d",
    "zkevm_l2_aggregator_private_key": "0x2857ca0e7748448f3a50469f7ffe55cde7299d5696aedd72cfe18a06fb856970",
    # claimtxmanager
    "zkevm_l2_claimtxmanager_address": "0x5f5dB0D4D58310F53713eF4Df80ba6717868A9f8",
    "zkevm_l2_claimtxmanager_private_key": "0x8d5c9ecd4ba2a195db3777c8412f8e3370ae9adffac222a54a84e116c7f8b934",
    # timelock
    "zkevm_l2_timelock_address": "0x130aA39Aa80407BD251c3d274d161ca302c52B7A",
    "zkevm_l2_timelock_private_key": "0x80051baf5a0a749296b9dcdb4a38a264d2eea6d43edcf012d20b5560708cf45f",
    # admin
    "zkevm_l2_admin_address": "0xE34aaF64b29273B7D567FCFc40544c014EEe9970",
    "zkevm_l2_admin_private_key": "0x12d7de8621a77640c9241b2595ba78ce443d05e94090365ab3bb5e19df82c625",
    # loadtest
    "zkevm_l2_loadtest_address": "0x81457240ff5b49CaF176885ED07e3E7BFbE9Fb81",
    "zkevm_l2_loadtest_private_key": "0xd7df6d64c569ffdfe7c56e6b34e7a2bdc7b7583db74512a9ffe26fe07faaa5de",
    # agglayer
    "zkevm_l2_agglayer_address": "0x351e560852ee001d5D19b5912a269F849f59479a",
    "zkevm_l2_agglayer_private_key": "0x1d45f90c0a9814d8b8af968fa0677dab2a8ff0266f33b136e560fe420858a419",
    # dac
    "zkevm_l2_dac_address": "0x5951F5b2604c9B42E478d5e2B2437F44073eF9A6",
    "zkevm_l2_dac_private_key": "0x85d836ee6ea6f48bae27b31535e6fc2eefe056f2276b9353aafb294277d8159b",
    # proofsigner
    "zkevm_l2_proofsigner_address": "0x7569cc70950726784c8D3bB256F48e43259Cb445",
    "zkevm_l2_proofsigner_private_key": "0x77254a70a02223acebf84b6ed8afddff9d3203e31ad219b2bf900f4780cf9b51",
}

DEFAULT_L1_ARGS = {
    # The L1 network identifier.
    "l1_chain_id": 271828,
    # This mnemonic will:
    # a) be used to create keystores for all the types of validators that we have, and
    # b) be used to generate a CL genesis.ssz that has the children validator keys already
    # preregistered as validators
    "l1_preallocated_mnemonic": "code code code code code code code code code code code quality",
    # The L1 HTTP RPC endpoint.
    "l1_rpc_url": "http://el-1-geth-lighthouse:8545",
    # The L1 WS RPC endpoint.
    "l1_ws_url": "ws://el-1-geth-lighthouse:8546",
    # The additional services to spin up.
    # Default: []
    # Options:
    #   - assertoor
    #   - broadcaster
    #   - tx_spammer
    #   - blob_spammer
    #   - custom_flood
    #   - goomy_blob
    #   - el_forkmon
    #   - blockscout
    #   - beacon_metrics_gazer
    #   - dora
    #   - full_beaconchain_explorer
    #   - prometheus_grafana
    #   - blobscan
    #   - dugtrio
    #   - blutgang
    #   - forky
    #   - apache
    #  - tracoor
    # Check the ethereum-package for more details: https://github.com/ethpandaops/ethereum-package
    "l1_additional_services": [],
    # Preset for the network.
    # Default: "mainnet"
    # Options:
    #   - mainnet
    #   - minimal
    # "minimal" preset will spin up a network with minimal preset. This is useful for rapid testing and development.
    # 192 seconds to get to finalized epoch vs 1536 seconds with mainnet defaults
    # Please note that minimal preset requires alternative client images.
    "l1_preset": "minimal",
    # Number of seconds per slot on the Beacon chain
    # Default: 12
    "l1_seconds_per_slot": 1,
    # The amount of ETH sent to the admin, sequence, aggregator and sequencer addresses.
    "l1_funding_amount": "100ether",
}

DEFAULT_ROLLUP_ARGS = {
    # The keystore password.
    "zkevm_l2_keystore_password": "pSnv6Dh5s9ahuzGzH9RoCDrKAMddaX3m",
    # The rollup network identifier.
    "zkevm_rollup_chain_id": 10101,
    # The unique identifier for the rollup within the RollupManager contract.
    # This setting sets the rollup as the first rollup.
    "zkevm_rollup_id": 1,
    # By default a mock verifier is deployed.
    # Change to true to deploy a real verifier which will require a real prover.
    # Note: This will require a lot of memory to run!
    "zkevm_use_real_verifier": False,
    # This flag will enable a stateless executor to verify the execution of the batches.
    # Set to true to run erigon as the sequencer.
    "erigon_strict_mode": True,
    # Set to true to automatically deploy an ERC20 contract on L1 to be used as the gas token on the rollup.
    "zkevm_use_gas_token_contract": False,
}

DEFAULT_PLESS_ZKEVM_NODE_ARGS = {
    "trusted_sequencer_node_uri": "zkevm-node-sequencer-001:6900",
    "zkevm_aggregator_host": "zkevm-node-aggregator-001",
    "genesis_file": "templates/permissionless-node/genesis.json",
}

DEFAULT_ARGS = (
    {
        # Suffix appended to service names.
        # Note: It should be a string.
        "deployment_suffix": "-001",
        # The global log level that all components of the stack should log at.
        # Valid values are "error", "warn", "info", "debug", and "trace".
        "global_log_level": "info",
        # The type of the sequencer to deploy.
        # Options:
        # - 'erigon': Use the new sequencer (https://github.com/0xPolygonHermez/cdk-erigon).
        # - 'zkevm': Use the legacy sequencer (https://github.com/0xPolygonHermez/zkevm-node).
        "sequencer_type": "erigon",
        # The type of data availability to use.
        # Options:
        # - 'rollup': Transaction data is stored on-chain on L1.
        # - 'cdk-validium': Transaction data is stored off-chain using the CDK DA layer and a DAC.
        # In the future, we would like to support external DA protocols such as Avail, Celestia and Near.
        "data_availability_mode": "cdk-validium",
        # Additional services to run alongside the network.
        # Options:
        # - arpeggio
        # - blockscout
        # - blutgang
        # - erpc
        # - pless_zkevm_node
        # - prometheus_grafana
        # - tx_spammer
        "additional_services": [],
        # Only relevant when deploying to an external L1.
        "polygon_zkevm_explorer": "https://explorer.private/",
        "l1_explorer_url": "https://sepolia.etherscan.io/",
    }
    | DEFAULT_IMAGES
    | DEFAULT_PORTS
    | DEFAULT_ACCOUNTS
    | DEFAULT_L1_ARGS
    | DEFAULT_ROLLUP_ARGS
    | DEFAULT_PLESS_ZKEVM_NODE_ARGS
)

# A list of fork identifiers currently supported by Kurtosis CDK.
SUPPORTED_FORK_IDS = [9, 11, 12, 13]


def parse_args(plan, args):
    # Merge the provided args with defaults.
    deployment_stages = DEFAULT_DEPLOYMENT_STAGES | args.get("deployment_stages", {})
    args = DEFAULT_ARGS | args.get("args", {})

    # Validation step.
    global_log_level = args.get("global_log_level", "")
    validate_global_log_level(global_log_level)

    # Determine fork id from the zkevm contracts image tag.
    zkevm_contracts_image = args.get("zkevm_contracts_image", "")
    fork_id = get_fork_id(zkevm_contracts_image)

    # Determine sequencer and l2 rpc names.
    sequencer_type = args.get("sequencer_type", "")
    sequencer_name = get_sequencer_name(sequencer_type)

    plan.print(
        "DEBUG: " + str(deployment_stages.get("deploy_cdk_erigon_node", False))
    )  # DEBUG
    deploy_cdk_erigon_node = deployment_stages.get("deploy_cdk_erigon_node", False)
    l2_rpc_name = get_l2_rpc_name(deploy_cdk_erigon_node)

    # Remove deployment stages from the args struct.
    # This prevents updating already deployed services when updating the deployment stages.
    if "deployment_stages" in args:
        args.pop("deployment_stages")

    args = args | {
        "l2_rpc_name": l2_rpc_name,
        "sequencer_name": sequencer_name,
        "zkevm_rollup_fork_id": fork_id,
        "deploy_agglayer": deployment_stages.get(
            "deploy_agglayer", False
        ),  # hacky but works fine for now.
    }

    # Sort dictionaries for debug purposes.
    sorted_deployment_stages = sort_dict_by_values(deployment_stages)
    sorted_args = sort_dict_by_values(args)
    return (sorted_deployment_stages, sorted_args)


def validate_global_log_level(global_log_level):
    if global_log_level not in (
        constants.GLOBAL_LOG_LEVEL.error,
        constants.GLOBAL_LOG_LEVEL.warn,
        constants.GLOBAL_LOG_LEVEL.info,
        constants.GLOBAL_LOG_LEVEL.debug,
        constants.GLOBAL_LOG_LEVEL.trace,
    ):
        fail(
            "Unsupported global log level: '{}', please use '{}', '{}', '{}', '{}' or '{}'".format(
                global_log_level,
                constants.GLOBAL_LOG_LEVEL.error,
                constants.GLOBAL_LOG_LEVEL.warn,
                constants.GLOBAL_LOG_LEVEL.info,
                constants.GLOBAL_LOG_LEVEL.debug,
                constants.GLOBAL_LOG_LEVEL.trace,
            )
        )


def get_fork_id(zkevm_contracts_image):
    """
    Extract the fork identifier from a zkevm contracts image name.

    The zkevm contracts tags follow the convention:
    v<SEMVER>-rc.<RC_NUMBER>-fork.<FORK_ID>

    Where:
    - <SEMVER> is the semantic versioning (MAJOR.MINOR.PATCH).
    - <RC_NUMBER> is the release candidate number.
    - <FORK_ID> is the fork identifier.

    Example:
    - v8.0.0-rc.2-fork.12
    - v7.0.0-rc.1-fork.10
    """
    result = zkevm_contracts_image.split("fork.")
    if len(result) != 2:
        fail(
            "The zkevm contracts image tag '{}' does not follow the standard v<SEMVER>-rc.<RC_NUMBER>-fork.<FORK_ID>".format(
                zkevm_contracts_image
            )
        )

    fork_id = int(result[1])
    if fork_id not in SUPPORTED_FORK_IDS:
        fail("The fork id '{}' is not supported by Kurtosis CDK".format(fork_id))
    return fork_id


def get_sequencer_name(sequencer_type):
    if sequencer_type == constants.SEQUENCER_TYPE.CDK_ERIGON:
        return constants.SEQUENCER_NAME.CDK_ERIGON
    elif sequencer_type == constants.SEQUENCER_TYPE.ZKEVM:
        return constants.SEQUENCER_NAME.ZKEVM
    else:
        fail(
            "Unsupported sequencer type: '{}', please use '{}' or '{}'".format(
                sequencer_type,
                constants.SEQUENCER_TYPE.CDK_ERIGON,
                constants.SEQUENCER_TYPE.ZKEVM,
            )
        )


def get_l2_rpc_name(deploy_cdk_erigon_node):
    if deploy_cdk_erigon_node:
        return "cdk-erigon-node"
    else:
        return "zkevm-node-rpc"


def sort_dict_by_values(d):
    sorted_items = sorted(d.items(), key=lambda x: x[0])
    return {k: v for k, v in sorted_items}
